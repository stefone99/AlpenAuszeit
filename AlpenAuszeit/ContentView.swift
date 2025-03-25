import SwiftUI

struct ContentView: View {
    @StateObject private var hotelViewModel = HotelViewModel()
    @StateObject private var tripViewModel = TripViewModel()
    @StateObject private var hikingViewModel = HikingViewModel()
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                CurrentView(
                    hotelViewModel: hotelViewModel,
                    weatherViewModel: weatherViewModel
                )
                .navigationTitle("Aktuell")
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
            
            Text("Aktivitäten folgen noch")
                .tabItem {
                    Label("Aktivitäten", systemImage: "figure.hiking")
                }
        }
        .accentColor(.blue)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
