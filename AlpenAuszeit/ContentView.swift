import SwiftUI

struct ContentView: View {
    @StateObject private var hotelViewModel = HotelViewModel()
    @StateObject private var tripViewModel = TripViewModel()
    @StateObject private var hikingViewModel = HikingViewModel()
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        TabView {
            CurrentView(
                hotelViewModel: hotelViewModel,
                weatherViewModel: weatherViewModel
            )
            .tabItem {
                Label("Aktuell", systemImage: "info.circle")
            }
            
            HotelListView(viewModel: hotelViewModel)
                .tabItem {
                    Label("Hotel", systemImage: "building")
                }
            
            TripListView(viewModel: tripViewModel)
                .tabItem {
                    Label("Fahrten", systemImage: "tram")
                }
            
            HikingListView(viewModel: hikingViewModel)
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
