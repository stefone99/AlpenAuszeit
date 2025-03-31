import SwiftUI

struct WeatherForecastCard: View {
    let weather: Weather
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
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
                Image(systemName: weather.condition.rawValue)
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
        .frame(width: 100, height: 150)
    }
}
