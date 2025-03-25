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
                Text(viewModel.formattedDate(for: weather))
                    .font(.caption)
                    .foregroundColor(.white)
                
                Image(systemName: weather.condition.rawValue)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                Text("\(String(format: "%.1f", weather.temperature))°C")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(weather.condition.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding()
        }
        .frame(width: 120, height: 150)
    }
}
