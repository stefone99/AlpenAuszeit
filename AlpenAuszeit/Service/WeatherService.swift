import SwiftUI
import WeatherKit
import CoreLocation

// Info.plist-Berechtigungen erforderlich:
// - Privacy - Location When In Use Usage Description
// - Privacy - Location Usage Description
// - WeatherKit Usage Description

// Service für die Integration mit Apple Weather API
class WeatherService {
    static let shared = WeatherService()
    
    private init() {}
    
    func getWeather(for location: CLLocation) async throws -> (current: AlpenAuszeit.Weather, forecast: [AlpenAuszeit.Weather]) {
        do {
            // Weather Kit-Anfrage des Systems
            let weatherService = WeatherKit.WeatherService.shared
            
            // Wetterdaten abrufen
            let currentWeatherData = try await weatherService.weather(for: location)
            let dailyForecast = try await weatherService.weather(for: location, including: .daily)
            
            // Aktuelle Wetterdaten extrahieren
            let tempValue = currentWeatherData.currentWeather.temperature.value
            let currentWeather = AlpenAuszeit.Weather(
                date: Date(),
                temperature: tempValue,
                condition: mapWeatherCondition(currentWeatherData.currentWeather.symbolName, temperature: tempValue),
                location: location.description
            )
            
            // Tagesvorhersage für die nächsten 5 Tage
            var forecastData: [AlpenAuszeit.Weather] = []
            
            // Tagesvorhersage abfragen und umwandeln
            for day in dailyForecast.forecast.prefix(5) {
                let tempValue = day.highTemperature.value
                let forecastDay = AlpenAuszeit.Weather(
                    date: day.date,
                    temperature: tempValue,
                    condition: mapWeatherCondition(day.symbolName, temperature: tempValue),
                    location: location.description
                )
                forecastData.append(forecastDay)
            }
            
            return (currentWeather, forecastData)
        } catch {
            throw error
        }
    }
    
    // Hilfsfunktion zum Konvertieren der Apple Weather-Symbol-Namen in die eigene Enumeration
    private func mapWeatherCondition(_ symbolName: String, temperature: Double) -> AlpenAuszeit.WeatherCondition {
        // Schnee nur bei Temperaturen unter 3°C zulassen
        if temperature < 3 && (symbolName.contains("snow") || symbolName.contains("sleet") || symbolName.contains("hail")) {
            return .snowy
        }
        
        if symbolName.contains("sun") || symbolName.contains("clear") {
            return .sunny
        } else if symbolName.contains("cloud.sun") || symbolName.contains("partly.cloudy") {
            return .partlyCloudy
        } else if symbolName.contains("cloud") && !symbolName.contains("rain") && !symbolName.contains("snow") {
            return .cloudy
        } else if symbolName.contains("rain") || symbolName.contains("drizzle") || symbolName.contains("storm") {
            return .rainy
        } else {
            // Fallback für andere Zustände
            return .partlyCloudy
        }
    }
}
