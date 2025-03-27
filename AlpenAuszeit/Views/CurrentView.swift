import SwiftUI

// Aktuell View
struct CurrentView: View {
    @ObservedObject var hotelViewModel: HotelViewModel
    @ObservedObject var weatherViewModel: WeatherViewModel
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Willkommen zur AlpenAuszeit!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Aktuelle Unterkunft
                if let currentHotel = hotelViewModel.currentHotel {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ihre aktuelle Unterkunft")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: HotelDetailView(hotel: currentHotel, viewModel: hotelViewModel)) {
                            HotelCard(hotel: currentHotel, viewModel: hotelViewModel)
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    Text("Keine aktuelle Unterkunft gefunden")
                        .padding(.horizontal)
                }
                
                // Wetter-Status-Anzeige
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Aktuelles Wetter")
                            .font(.headline)
                        
                        Spacer()
                        
                        if weatherViewModel.isLoading {
                            ProgressView()
                        }
                    }
                    .padding(.horizontal)
                
                    // Aktuelles Wetter
                    if let currentWeather = weatherViewModel.currentWeather {
                        WeatherView(weather: currentWeather, viewModel: weatherViewModel)
                            .padding(.horizontal)
                    } else {
                        Text("Keine Wetterdaten verfügbar")
                            .padding(.horizontal)
                            .padding(.vertical, 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                
                // Wettervorhersage
                VStack(alignment: .leading, spacing: 12) {
                    Text("Wettervorhersage")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            // Falls es noch keine Vorhersagedaten gibt
                            if weatherViewModel.weatherData.count <= 1 {
                                ForEach(0..<5, id: \.self) { _ in
                                    // Platzhalter-Karten
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 120, height: 150)
                                        
                                        if weatherViewModel.isLoading {
                                            ProgressView()
                                        } else {
                                            Text("Keine Daten")
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                        }
                                    }
                                }
                            } else {
                                // Echte Vorhersagedaten anzeigen
                                ForEach(weatherViewModel.weatherData.dropFirst()) { weather in
                                    WeatherForecastCard(weather: weather, viewModel: weatherViewModel)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            // Bei jedem Erscheinen der View sofort Wetterdaten laden mit dem vorhandenen Standort
            Task {
                // Immer einen gültigen Standort haben, dank des verbesserten LocationManagers
                let location = locationManager.getCurrentOrDefaultLocation()
                print("CurrentView: onAppear - Lade Wetterdaten für Standort: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                await weatherViewModel.fetchRealWeatherData(for: location)
            }
        }
    }
}
