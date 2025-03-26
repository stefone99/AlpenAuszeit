import SwiftUI
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    // Zugriff auf den LocationManager über Environment Object
    @ObservedObject var locationManager: LocationManager
    
    @Published var weatherData: [Weather] = []
    @Published var currentWeather: Weather?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        formatter.locale = Locale(identifier: "de_DE")
        return formatter
    }()
    
    // Speicher für die Publisher-Subscription
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        
        // Zu Beginn Mock-Daten laden (werden später durch echte Daten ersetzt)
        loadMockWeatherData()
        
        // Beobachten, wenn sich der Standort ändert, um Wetterdaten zu aktualisieren
        locationManager.$location
            .sink { [weak self] location in
                guard let self = self, let location = location else {
                    print("LocationManager: Kein Standort verfügbar")
                    return
                }
                
                print("WeatherViewModel: Neuer Standort empfangen: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                
                Task {
                    print("WeatherViewModel: Starte Wetterdaten-Abfrage für neuen Standort")
                    await self.fetchRealWeatherData(for: location)
                }
            }
            .store(in: &cancellables)
        
        // Sofort Wetterdaten abrufen, wenn ein Standort verfügbar ist
        if let location = locationManager.location {
            print("WeatherViewModel: Initial vorhandener Standort: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            Task {
                print("WeatherViewModel: Starte initiale Wetterdaten-Abfrage")
                await self.fetchRealWeatherData(for: location)
            }
        } else {
            print("WeatherViewModel: Kein initialer Standort verfügbar, warte auf Standortdaten")
        }
    }
    
    // Lädt Wetterdaten von Apple Weather für den übergebenen Standort
    @MainActor
    func fetchRealWeatherData(for location: CLLocation? = nil) async {
        // Standort aus Parameter oder LocationManager verwenden
        // Falls nichts verfügbar ist, Standardstandort (Wien) nutzen
        let locationToUse: CLLocation
        
        if let location = location {
            print("WeatherViewModel: Nutze übergebenen Standort: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            locationToUse = location
        } else if let managerLocation = locationManager.location {
            print("WeatherViewModel: Nutze LocationManager-Standort: \(managerLocation.coordinate.latitude), \(managerLocation.coordinate.longitude)")
            locationToUse = managerLocation
        } else {
            // Sollte nicht mehr vorkommen, da LocationManager immer einen Standort hat
            let coordinates = CLLocationCoordinate2D(latitude: 48.2082, longitude: 16.3738)
            print("WeatherViewModel: Kein Standort verfügbar, nutze Fallback Wien: \(coordinates.latitude), \(coordinates.longitude)")
            locationToUse = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            print("WeatherViewModel: Starte offizielle WeatherKit-Abfrage für Standort \(locationToUse.coordinate.latitude), \(locationToUse.coordinate.longitude)")
            let weatherService = WeatherService.shared
            let (current, forecast) = try await weatherService.getWeather(for: locationToUse)
            
            // UI-Update im Hauptthread
            print("WeatherViewModel: Wetterdaten erfolgreich abgerufen: \(current.temperature)°C, \(current.condition.description) in \(current.location)")
            self.currentWeather = current
                
            // Aktuelle Wetterdaten und Vorhersage kombinieren
            var allWeatherData = [current]
            allWeatherData.append(contentsOf: forecast)
            self.weatherData = allWeatherData
                
            self.isLoading = false
        } catch {
            // Fehler verarbeiten
            print("WeatherViewModel: Fehler bei Wetterdaten-Abfrage: \(error.localizedDescription)")
            self.errorMessage = "Wetterdaten konnten nicht abgerufen werden: \(error.localizedDescription)"
            self.isLoading = false
                
            // Bei Fehler bleiben wir bei den Mock-Daten
            print("WeatherViewModel: Verwende Mock-Daten wegen Fehler")
            
            // Sicherstellen, dass wir Mock-Daten haben, falls die aktuellen Daten leer sind
            if self.weatherData.isEmpty {
                self.loadMockWeatherData()
            }
        }
    }
    
    // Mock-Daten für den Fall, dass die Wetter-API nicht verfügbar ist
    func loadMockWeatherData() {
        let today = Date()
        let calendar = Calendar.current
        
        let currentWeather = Weather(
            date: today,
            temperature: 15.5,
            condition: .partlyCloudy,
            location: "Fehlende Daten"
        )
        
        var allWeatherData = [currentWeather]
        
        // Wettervorhersage für die nächsten 5 Tage
        for dayOffset in 1...5 {
            if let futureDate = calendar.date(byAdding: .day, value: dayOffset, to: today) {
                // Zufällige Wetterdaten für die Demo
                let conditions: [WeatherCondition] = [.sunny, .partlyCloudy, .cloudy, .rainy, .snowy]
                let randomCondition = conditions[Int.random(in: 0..<conditions.count)]
                let randomTemp = Double.random(in: 10...25)
                
                allWeatherData.append(
                    Weather(
                        date: futureDate,
                        temperature: randomTemp,
                        condition: randomCondition,
                        location: "Fehlende Daten"
                    )
                )
            }
        }
        
        weatherData = allWeatherData
        self.currentWeather = allWeatherData.first
        print("WeatherViewModel: Mock-Wetterdaten geladen (nur für Notfälle)")
    }
    
    func formattedDate(for weather: Weather) -> String {
        return dateFormatter.string(from: weather.date)
    }
}
