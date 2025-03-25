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
