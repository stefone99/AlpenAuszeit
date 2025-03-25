import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var weatherData: [Weather] = []
    @Published var currentWeather: Weather?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        formatter.locale = Locale(identifier: "de_DE")
        return formatter
    }()
    
    init() {
        // Für Demo-Zwecke laden wir simulierte Wetterdaten
        loadMockWeatherData()
    }
    
    func loadMockWeatherData() {
        let today = Date()
        let calendar = Calendar.current
        
        weatherData = [
            Weather(
                date: today,
                temperature: 15.5,
                condition: .partlyCloudy,
                location: "Wien"
            )
        ]
        
        // Wettervorhersage für die nächsten 5 Tage
        for dayOffset in 1...5 {
            if let futureDate = calendar.date(byAdding: .day, value: dayOffset, to: today) {
                // Zufällige Wetterdaten für die Demo
                let conditions: [WeatherCondition] = [.sunny, .partlyCloudy, .cloudy, .rainy, .snowy]
                let randomCondition = conditions[Int.random(in: 0..<conditions.count)]
                let randomTemp = Double.random(in: 10...25)
                
                weatherData.append(
                    Weather(
                        date: futureDate,
                        temperature: randomTemp,
                        condition: randomCondition,
                        location: "Wien"
                    )
                )
            }
        }
        
        currentWeather = weatherData.first
    }
    
    func formattedDate(for weather: Weather) -> String {
        return dateFormatter.string(from: weather.date)
    }
}
