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
            
            if viewModel.isLoading {
                // Ladeanzeige
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                    
                    Text("Wetterdaten werden geladen...")
                        .foregroundColor(.white)
                        .padding(.top, 10)
                }
            } else if let errorMessage = viewModel.errorMessage {
                // Fehlermeldung
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                    
                    Text("Fehler beim Laden der Wetterdaten")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            } else {
                // Normale Wetteranzeige
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.formattedDate(for: weather))
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(weather.location)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text("\(Int(weather.temperature))°C")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(weather.condition.description)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    Image(systemName: weather.condition.iconName)
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
        .frame(height: 150)
    }
}
