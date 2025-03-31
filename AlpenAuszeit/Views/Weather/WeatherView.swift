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
                // Normale Wetteranzeige mit erweiterter Temperaturanzeige
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 8) {
                        // Datum und Ort
                        Text(viewModel.formattedDate(for: weather))
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text(weather.location)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                        
                        // Aktuelle Temperatur größer
                        Text("\(Int(weather.temperature))°C")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        // Temperaturbereich in einer Zeile
                        HStack(spacing: 10) {
                            // Niedrigste Temperatur
                            HStack(spacing: 2) {
                                Image(systemName: "thermometer.low")
                                    .foregroundColor(.white.opacity(0.8))
                                Text("\(Int(weather.lowTemperature))°")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            
                            // Höchsttemperatur
                            HStack(spacing: 2) {
                                Image(systemName: "thermometer.high")
                                    .foregroundColor(.white.opacity(0.8))
                                Text("\(Int(weather.highTemperature))°")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                        
                        // Wetterbedingung
                        Text(weather.condition.description)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    // Wettericon
                    Image(systemName: weather.condition.iconName)
                        .font(.system(size: 56))
                        .foregroundColor(.white)
                        .frame(width: 70, height: 70)
                }
                .padding()
            }
        }
        .frame(height: 170) // Etwas mehr Höhe für zusätzliche Informationen
    }
}
