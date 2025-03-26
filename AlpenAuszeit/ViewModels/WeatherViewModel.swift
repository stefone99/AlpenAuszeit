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
        
        // Zu Beginn Mock-Daten laden
        loadMockWeatherData()
        
        // Beobachten, wenn sich der Standort ändert, um Wetterdaten zu aktualisieren
        locationManager.$location
            .sink { [weak self] location in
                guard let self = self, let location = location else { return }
                
                Task {
                    await self.fetchRealWeatherData(for: location)
                }
            }
            .store(in: &cancellables)
    }
    
    // Lädt Wetterdaten von Apple Weather für den übergebenen Standort
    @MainActor
    func fetchRealWeatherData(for location: CLLocation? = nil) async {
        // Standort aus Parameter oder LocationManager verwenden
        // Falls nichts verfügbar ist, Standardstandort (Wien) nutzen
        let locationToUse: CLLocation
        
        if let location = location {
            locationToUse = location
        } else if let managerLocation = locationManager.location {
            locationToUse = managerLocation
        } else {
            let coordinates = CLLocationCoordinate2D(latitude: 48.2082, longitude: 16.3738)
            locationToUse = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let weatherService = WeatherService.shared
            let (current, forecast) = try await weatherService.getWeather(for: locationToUse)
            
            // UI-Update im Hauptthread
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.currentWeather = current
                
                // Aktuelle Wetterdaten und Vorhersage kombinieren
                var allWeatherData = [current]
                allWeatherData.append(contentsOf: forecast)
                self.weatherData = allWeatherData
                
                self.isLoading = false
            }
        } catch {
            // Fehler im Hauptthread verarbeiten
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.errorMessage = "Wetterdaten konnten nicht abgerufen werden: \(error.localizedDescription)"
                self.isLoading = false
                
                // Bei Fehler bleiben wir bei den Mock-Daten
                print("Wetterfehler: \(error.localizedDescription)")
            }
        }
    }
    
    // Demo-Daten für den Fall, dass die Wetter-API nicht verfügbar ist
    func loadMockWeatherData() {
        let today = Date()
        let calendar = Calendar.current
        
        weatherData = [
            Weather(
                date: today,
                temperature: 15.5,
                condition: .partlyCloudy,
                location: "Wien"
            )
        ]
        
        // Wettervorhersage für die nächsten 5 Tage
        for dayOffset in 1...5 {
            if let futureDate = calendar.date(byAdding: .day, value: dayOffset, to: today) {
                // Zufällige Wetterdaten für die Demo
                let conditions: [WeatherCondition] = [.sunny, .partlyCloudy, .cloudy, .rainy, .snowy]
                let randomCondition = conditions[Int.random(in: 0..<conditions.count)]
                let randomTemp = Double.random(in: 10...25)
                
                weatherData.append(
                    Weather(
                        date: futureDate,
                        temperature: randomTemp,
                        condition: randomCondition,
                        location: "Wien"
                    )
                )
            }
        }
        
        currentWeather = weatherData.first
    }
    
    func formattedDate(for weather: Weather) -> String {
        return dateFormatter.string(from: weather.date)
    }
}
