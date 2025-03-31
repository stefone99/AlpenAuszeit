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
            
            print("WeatherService: Starte Anfrage für Standort \(location.coordinate.latitude), \(location.coordinate.longitude)")
            
            // Wetterdaten abrufen
            print("WeatherService: Fordere aktuelle Wetterdaten an")
            let currentWeatherData = try await weatherService.weather(for: location)
            
            print("WeatherService: Fordere Vorhersagedaten an")
            let dailyForecast = try await weatherService.weather(for: location, including: .daily)
            
            // Ort mit Geocoder ermitteln
            let geocoder = CLGeocoder()
            var locationName = "Aktuelle Position"
            
            do {
                print("WeatherService: Führe Geocoding für Standortnamen durch")
                let placemarks = try await geocoder.reverseGeocodeLocation(location)
                if let placemark = placemarks.first, let locality = placemark.locality {
                    locationName = locality
                    print("WeatherService: Standortname ermittelt: \(locationName)")
                } else if let placemark = placemarks.first, let name = placemark.name {
                    locationName = name
                    print("WeatherService: Alternativer Standortname: \(locationName)")
                }
            } catch {
                print("WeatherService: Geocoding-Fehler: \(error.localizedDescription)")
            }
            
            // Aktuelle Wetterdaten extrahieren
            let temp = currentWeatherData.currentWeather.temperature.value
            let symbolName = currentWeatherData.currentWeather.symbolName
            
            // Debug-Ausgabe der empfangenen Wetterdaten
            print("WeatherService: Aktuelle Wetterdaten empfangen:")
            print("- Temperatur: \(temp)")
            print("- Symbol: \(symbolName)")
            print("- Standort: \(locationName)")
            
            let condition = mapWeatherCondition(symbolName, temperature: temp, originalCondition: currentWeatherData.currentWeather.condition.description)
            
            // Für aktuelle Wetterdaten - versuche, die Tagesvorhersage für heute zu finden,
            // um Höchst-/Tiefsttemperaturen zu erhalten
            var todayHigh = temp
            var todayLow = temp
            
            if let todayForecast = dailyForecast.forecast.first {
                todayHigh = todayForecast.highTemperature.value
                todayLow = todayForecast.lowTemperature.value
                print("WeatherService: Heute - Min: \(todayLow), Max: \(todayHigh)")
            }
            
            let currentWeather = AlpenAuszeit.Weather(
                date: Date(),
                temperature: temp,
                condition: condition,
                location: locationName,
                highTemperature: todayHigh,
                lowTemperature: todayLow
            )
            
            // Tagesvorhersage für die nächsten 5 Tage
            var forecastData: [AlpenAuszeit.Weather] = []
            
            // Tagesvorhersage abfragen und umwandeln
            for day in dailyForecast.forecast.prefix(5) {
                let highTemp = day.highTemperature.value
                let lowTemp = day.lowTemperature.value
                let symbolName = day.symbolName
                let originalCondition = day.condition.description
                
                // Debug-Ausgabe für jeden Vorhersagetag
                print("WeatherService: Vorhersage für \(day.date):")
                print("- Min: \(lowTemp)")
                print("- Max: \(highTemp)")
                print("- Symbol: \(symbolName)")
                print("- Bedingung: \(originalCondition)")
                
                let mappedCondition = mapWeatherCondition(symbolName, temperature: highTemp, originalCondition: originalCondition)
                
                let forecastDay = AlpenAuszeit.Weather(
                    date: day.date,
                    temperature: highTemp, // Verwende Höchsttemperatur als Hauptwert
                    condition: mappedCondition,
                    location: locationName,
                    highTemperature: highTemp,
                    lowTemperature: lowTemp
                )
                forecastData.append(forecastDay)
            }
            
            print("WeatherService: Daten erfolgreich abgerufen und umgewandelt")
            return (currentWeather, forecastData)
        } catch {
            print("WeatherService: Allgemeiner Fehler: \(error.localizedDescription)")
            throw error
        }
    }
    
    // Verbesserte Funktion zum Konvertieren der Apple Weather-Symbol-Namen in die eigene Enumeration
    private func mapWeatherCondition(_ symbolName: String, temperature: Double, originalCondition: String) -> AlpenAuszeit.WeatherCondition {
        // Debug-Logging für Symbol-Name
        print("WeatherService: Apple Weather symbol name: \(symbolName), original condition: \(originalCondition)")
        
        // Spezifischere Bedingungs-Zuordnungen
        
        // Snow Conditions
        if (temperature < 3 && (
            symbolName.contains("snow") ||
            symbolName.contains("sleet") ||
            symbolName.contains("wintry.mix")
        )) || symbolName.contains("snow") {
            return .snowy
        }
        
        // Sunny/Clear Conditions
        if symbolName.contains("sun.max") ||
           symbolName.contains("clear") {
            return .sunny
        }
        
        // Partly Cloudy
        if symbolName.contains("cloud.sun") ||
           symbolName.contains("partly-cloudy") {
            return .partlyCloudy
        }
        
        // Rain Conditions
        if symbolName.contains("rain") ||
           symbolName.contains("drizzle") ||
           symbolName.contains("shower") ||
           symbolName.contains("storm") {
            return .rainy
        }
        
        // Cloudy, allgemeinere Bedingung erst zum Schluss prüfen
        if symbolName.contains("cloud") {
            return .cloudy
        }
        
        // Textbasierte Analyse für Fallback
        let lowerCondition = originalCondition.lowercased()
        
        if lowerCondition.contains("snow") || lowerCondition.contains("schnee") {
            return .snowy
        }
        
        if lowerCondition.contains("sun") || lowerCondition.contains("clear") ||
           lowerCondition.contains("sonn") || lowerCondition.contains("klar") {
            return .sunny
        }
        
        if lowerCondition.contains("partly") || lowerCondition.contains("teilweise") {
            return .partlyCloudy
        }
        
        if lowerCondition.contains("rain") || lowerCondition.contains("shower") ||
           lowerCondition.contains("regen") {
            return .rainy
        }
        
        if lowerCondition.contains("cloud") || lowerCondition.contains("bewölkt") {
            return .cloudy
        }
        
        // Fallback für nicht zugeordnete Bedingungen
        print("WeatherService: Unbekannter Wetterzustand: \(symbolName), \(originalCondition) - verwende teilweise bewölkt als Fallback")
        return .partlyCloudy
    }
}
