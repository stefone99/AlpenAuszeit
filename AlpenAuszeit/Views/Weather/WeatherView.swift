import SwiftUI

struct WeatherView: View {
    let weather: Weather
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue.opacity(0.4)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .shadow(radius: 5)
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.formattedDate(for: weather))
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(weather.location)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text("\(String(format: "%.1f", weather.temperature))°C")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(weather.condition.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
                
                Image(systemName: weather.condition.rawValue)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }
            .padding()
        }
        .frame(height: 150)
    }
}

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
