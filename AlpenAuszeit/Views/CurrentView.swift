import SwiftUI

// Aktuell View
struct CurrentView: View {
    @ObservedObject var hotelViewModel: HotelViewModel
    @ObservedObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Willkommen zu Ihrem Urlaub in Östirol!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Aktuelle Unterkunft
                if let currentHotel = hotelViewModel.currentHotel {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ihre aktuelle Unterkunft")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HotelCard(hotel: currentHotel, viewModel: hotelViewModel)
                            .padding(.horizontal)
                    }
                } else {
                    Text("Keine aktuelle Unterkunft gefunden")
                        .padding(.horizontal)
                }
                
                // Aktuelles Wetter
                if let currentWeather = weatherViewModel.currentWeather {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Aktuelles Wetter")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        WeatherView(weather: currentWeather, viewModel: weatherViewModel)
                            .padding(.horizontal)
                    }
                }
                
                // Wettervorhersage
                VStack(alignment: .leading, spacing: 12) {
                    Text("Wettervorhersage")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(weatherViewModel.weatherData.dropFirst()) { weather in
                                WeatherForecastCard(weather: weather, viewModel: weatherViewModel)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
