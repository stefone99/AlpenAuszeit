import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var hotelViewModel = HotelViewModel()
    @StateObject private var tripViewModel = TripViewModel()
    @StateObject private var hikingViewModel = HikingViewModel()
    @StateObject private var climbingViewModel = ClimbingViewModel()
    
    // Wetter-ViewModel mit dem LocationManager initialisieren
    @StateObject private var weatherViewModel: WeatherViewModel
    
    // Initialisierer für die ViewModel-Erstellung mit dem LocationManager
    init() {
        // Da wir @EnvironmentObject erst in der View haben, müssen wir einen
        // temporären LocationManager für die Initialisierung erstellen
        let tempLocationManager = LocationManager()
        _weatherViewModel = StateObject(wrappedValue: WeatherViewModel(locationManager: tempLocationManager))
    }
    
    var body: some View {
        TabView {
            NavigationView {
                CurrentView(
                    hotelViewModel: hotelViewModel,
                    weatherViewModel: weatherViewModel
                )
                .navigationTitle("Aktuell")
                // Toolbar ohne Reload-Button
            }
            .tabItem {
                Label("Aktuell", systemImage: "info.circle")
            }
            
            NavigationView {
                HotelListView(viewModel: hotelViewModel)
                    .navigationTitle("Hotels")
            }
            .tabItem {
                Label("Hotel", systemImage: "building")
            }
            
            NavigationView {
                TripListView(viewModel: tripViewModel)
                    .navigationTitle("Fahrten")
            }
            .tabItem {
                Label("Fahrten", systemImage: "tram")
            }
            
            NavigationView {
                HikingListView(viewModel: hikingViewModel)
                    .navigationTitle("Wanderungen")
            }
            .tabItem {
                Label("Wanderungen", systemImage: "mountain.2")
            }
            
            NavigationView {
                ClimbingListView(viewModel: climbingViewModel)
                    .navigationTitle("Klettersteige")
            }
            .tabItem {
                Label("Klettersteige", systemImage: "figure.climbing")
            }
        }
        .accentColor(.blue)
        .onAppear {
            // Nach dem Erscheinen der View den LocationManager aktualisieren
            weatherViewModel.locationManager = locationManager
            
            // Standortaktualisierung anfordern
            if locationManager.authorizationStatus == .authorizedWhenInUse ||
               locationManager.authorizationStatus == .authorizedAlways {
                locationManager.requestLocation()
            }
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationManager())
    }
}
