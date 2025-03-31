import SwiftUI

struct WeatherForecastCard: View {
    let weather: Weather
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            // Hintergrund mit abgerundeten Ecken
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.3)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(radius: 3)
            
            VStack(spacing: 8) {
                // Datum
                Text(viewModel.formattedDate(for: weather))
                    .font(.caption)
                    .foregroundColor(.white)
                
                // Wettericon
                Image(systemName: weather.condition.iconName)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                // Wetterbeschreibung
                Text(weather.condition.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(1)
                
                Spacer()
                    .frame(height: 4)
                
                // Haupttemperatur (Höchsttemperatur)
                Text("\(Int(weather.highTemperature))°")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Niedrigsttemperatur
                Text("\(Int(weather.lowTemperature))°")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .frame(width: 100, height: 150)
    }
}

struct WeatherForecastCard_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastCard(
            weather: Weather(
                date: Date(),
                temperature: 22.5,
                condition: .sunny,
                location: "Wien",
                highTemperature: 25.0,
                lowTemperature: 18.0
            ),
            viewModel: WeatherViewModel(locationManager: LocationManager())
        )
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}
