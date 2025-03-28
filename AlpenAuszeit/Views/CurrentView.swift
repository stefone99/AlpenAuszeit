import SwiftUI

// Aktuell View
struct CurrentView: View {
    @ObservedObject var hotelViewModel: HotelViewModel
    @ObservedObject var weatherViewModel: WeatherViewModel
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viennaActivityViewModel = ViennaActivityViewModel()
    @State private var randomActivity: ViennaActivity?
    
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
                        Text("Aktuelle Unterkunft")
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
                
                // Zufällige Wien-Aktivität
                if let activity = randomActivity {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Entdecke Wien")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: ViennaActivityDetailView(activity: activity)) {
                            VStack(spacing: 0) {
                                // Aktivitätskarte
                                ZStack(alignment: .bottom) {
                                    // Bild mit Farbverlauf
                                    if let imageURL = activity.imageURL {
                                        ZStack(alignment: .bottom) {
                                            AsyncImage(url: imageURL) { phase in
                                                switch phase {
                                                case .empty:
                                                    Rectangle()
                                                        .fill(activity.category.color.opacity(0.2))
                                                        .frame(height: 180)
                                                        .overlay(ProgressView())
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(height: 180)
                                                        .clipped()
                                                case .failure:
                                                    Rectangle()
                                                        .fill(activity.category.color.opacity(0.2))
                                                        .frame(height: 180)
                                                        .overlay(
                                                            Image(systemName: "photo")
                                                                .font(.largeTitle)
                                                                .foregroundColor(activity.category.color)
                                                        )
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                            
                                            // Text-Overlay mit Gradient
                                            VStack(alignment: .leading, spacing: 4) {
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 4) {
                                                        HStack {
                                                            Text(activity.name)
                                                                .font(.headline)
                                                                .foregroundColor(.white)
                                                            
                                                            Spacer()
                                                            
                                                            Image(systemName: "chevron.right")
                                                                .foregroundColor(.white.opacity(0.7))
                                                                .font(.caption)
                                                        }
                                                        
                                                        HStack {
                                                            Image(systemName: activity.category.icon)
                                                                .foregroundColor(.white)
                                                            Text(activity.category.rawValue)
                                                                .font(.caption)
                                                                .foregroundColor(.white.opacity(0.9))
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 12)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.0)]),
                                                    startPoint: .bottom,
                                                    endPoint: .top
                                                )
                                            )
                                        }
                                    } else {
                                        Rectangle()
                                            .fill(activity.category.color.opacity(0.2))
                                            .frame(height: 180)
                                            .overlay(
                                                Text(activity.name)
                                                    .font(.headline)
                                                    .foregroundColor(activity.category.color)
                                            )
                                    }
                                }
                            }
                            .cornerRadius(12)
                            .shadow(radius: 3)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                }
                
                // Wetter-Status-Anzeige
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Aktuelles Wetter Wien")
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
                    Text("Wettervorhersage Wien")
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
            
            // Zufällige Aktivität auswählen
            selectRandomActivity()
        }
    }
    
    // Helfer-Methode zur Auswahl einer zufälligen Aktivität
    private func selectRandomActivity() {
        if !viennaActivityViewModel.activities.isEmpty {
            randomActivity = viennaActivityViewModel.activities.randomElement()
        }
    }
}

// Preview
struct CurrentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CurrentView(
                hotelViewModel: HotelViewModel(),
                weatherViewModel: WeatherViewModel(locationManager: LocationManager())
            )
            .environmentObject(LocationManager())
        }
    }
}
