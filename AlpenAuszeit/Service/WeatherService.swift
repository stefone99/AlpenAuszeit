import SwiftUI
import WeatherKit
import CoreLocation

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
            
            // Ort mit Geocoder ermitteln
            let geocoder = CLGeocoder()
            var locationName = "Aktuelle Position"
            
            do {
                let placemarks = try await geocoder.reverseGeocodeLocation(location)
                if let placemark = placemarks.first, let locality = placemark.locality {
                    locationName = locality
                } else if let placemark = placemarks.first, let name = placemark.name {
                    locationName = name
                }
            } catch {
                print("Geocoding-Fehler: \(error.localizedDescription)")
            }
            
            // Aktuelle Wetterdaten extrahieren mit detailliertem Logging
            let temp = currentWeatherData.currentWeather.temperature
            let tempValue = temp.value
            let tempUnit = temp.unit
            let symbolName = currentWeatherData.currentWeather.symbolName
            
            // Debug-Ausgabe der empfangenen Wetterdaten
            print("Aktuelle Wetterdaten empfangen:")
            print("- Temperatur: \(tempValue) \(tempUnit)")
            print("- Symbol: \(symbolName)")
            print("- Standort: \(locationName)")
            
            let currentWeather = AlpenAuszeit.Weather(
                date: Date(),
                temperature: tempValue,
                condition: mapWeatherCondition(symbolName, temperature: tempValue),
                location: locationName
            )
            
            // Tagesvorhersage für die nächsten 5 Tage
            var forecastData: [AlpenAuszeit.Weather] = []
            
            // Tagesvorhersage abfragen und umwandeln
            for day in dailyForecast.forecast.prefix(5) {
                let highTemp = day.highTemperature
                let lowTemp = day.lowTemperature
                let avgTemp = (highTemp.value + lowTemp.value) / 2
                let symbolName = day.symbolName
                
                // Debug-Ausgabe für jeden Vorhersagetag
                print("Vorhersage für \(day.date):")
                print("- Min: \(lowTemp.value) \(lowTemp.unit)")
                print("- Max: \(highTemp.value) \(highTemp.unit)")
                print("- Symbol: \(symbolName)")
                
                let forecastDay = AlpenAuszeit.Weather(
                    date: day.date,
                    temperature: avgTemp, // Durchschnittstemperatur verwenden
                    condition: mapWeatherCondition(symbolName, temperature: avgTemp),
                    location: locationName
                )
                forecastData.append(forecastDay)
            }
            
            return (currentWeather, forecastData)
        } catch {
            print("WeatherKit-Fehler: \(error.localizedDescription)")
            throw error
        }
    }
    
    // Verbesserte Funktion zum Konvertieren der Apple Weather-Symbol-Namen in die eigene Enumeration
    private func mapWeatherCondition(_ symbolName: String, temperature: Double) -> AlpenAuszeit.WeatherCondition {
        // Debug-Logging für Symbol-Name
        print("Apple Weather symbol name: \(symbolName)")
        
        // Schnee nur bei Temperaturen unter 3°C zulassen
        if temperature < 3 && (symbolName.contains("snow") || symbolName.contains("sleet") || symbolName.contains("wintry.mix") || symbolName.contains("hail")) {
            return .snowy
        }
        
        // Erkennung sonniger Bedingungen
        if symbolName.contains("sun.max") || symbolName.contains("clear") {
            return .sunny
        }
        // Erkennung teilweise bewölkter Bedingungen
        else if symbolName.contains("cloud.sun") || symbolName.contains("partly-cloudy") {
            return .partlyCloudy
        }
        // Erkennung bewölkter Bedingungen
        else if (symbolName.contains("cloud") && !symbolName.contains("rain") && !symbolName.contains("snow")) || symbolName.contains("overcast") {
            return .cloudy
        }
        // Erkennung von Regenbedingungen
        else if symbolName.contains("rain") || symbolName.contains("drizzle") || symbolName.contains("shower") || symbolName.contains("storm") {
            return .rainy
        }
        // Fallback für nicht zugeordnete Bedingungen
        else {
            print("Unbekannter Wetterzustand: \(symbolName)")
            return .partlyCloudy
        }
    }
}
