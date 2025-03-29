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
            
            // Aktuelle Wetterdaten extrahieren mit detailliertem Logging
            let temp = currentWeatherData.currentWeather.temperature
            let tempValue = temp.value
            let tempUnit = temp.unit
            let symbolName = currentWeatherData.currentWeather.symbolName
            
            // Debug-Ausgabe der empfangenen Wetterdaten
            print("WeatherService: Aktuelle Wetterdaten empfangen:")
            print("- Temperatur: \(tempValue) \(tempUnit)")
            print("- Symbol: \(symbolName)")
            print("- Standort: \(locationName)")
            print("- Bedingung: \(currentWeatherData.currentWeather.condition.description)")
            print("- Luftfeuchtigkeit: \(currentWeatherData.currentWeather.humidity)")
            print("- Wind: \(currentWeatherData.currentWeather.wind.speed)")
            
            let condition = mapWeatherCondition(symbolName, temperature: tempValue, originalCondition: currentWeatherData.currentWeather.condition.description)
            
            print("WeatherService: Gemappte Wetterbedingung: \(condition.description)")
            
            let currentWeather = AlpenAuszeit.Weather(
                date: Date(),
                temperature: tempValue,
                condition: condition,
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
                let originalCondition = day.condition.description
                
                // Debug-Ausgabe für jeden Vorhersagetag
                print("WeatherService: Vorhersage für \(day.date):")
                print("- Min: \(lowTemp.value) \(lowTemp.unit)")
                print("- Max: \(highTemp.value) \(highTemp.unit)")
                print("- Symbol: \(symbolName)")
                print("- Bedingung: \(originalCondition)")
                
                let mappedCondition = mapWeatherCondition(symbolName, temperature: avgTemp, originalCondition: originalCondition)
                
                let forecastDay = AlpenAuszeit.Weather(
                    date: day.date,
                    temperature: avgTemp, // Durchschnittstemperatur verwenden
                    condition: mappedCondition,
                    location: locationName
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
        
        // Direkte Zuordnung basierend auf dem Symbol-Namen
        
        // Schnee-Bedingung
        if temperature < 3 && (
            symbolName.contains("snow") ||
            symbolName.contains("sleet") ||
            symbolName.contains("wintry.mix") ||
            symbolName.contains("hail")
        ) {
            return .snowy
        }
        
        // Sonnige Bedingung
        if symbolName.contains("sun.max") ||
           symbolName.contains("clear") {
            return .sunny
        }
        
        // Teilweise bewölkt
        if symbolName.contains("cloud.sun") ||
           symbolName.contains("partly-cloudy") {
            return .partlyCloudy
        }
        
        // Bewölkt
        if (symbolName.contains("cloud") &&
            !symbolName.contains("rain") &&
            !symbolName.contains("snow")) ||
            symbolName.contains("overcast") {
            return .cloudy
        }
        
        // Regen
        if symbolName.contains("rain") ||
           symbolName.contains("drizzle") ||
           symbolName.contains("shower") ||
           symbolName.contains("storm") {
            return .rainy
        }
        
        // Analyse des Originaltextes als Fallback
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
        
        if lowerCondition.contains("cloud") || lowerCondition.contains("overcast") ||
           lowerCondition.contains("wolke") || lowerCondition.contains("bewölkt") {
            return .cloudy
        }
        
        if lowerCondition.contains("rain") || lowerCondition.contains("shower") ||
           lowerCondition.contains("drizzle") || lowerCondition.contains("regen") {
            return .rainy
        }
        
        // Fallback für nicht zugeordnete Bedingungen
        print("WeatherService: Unbekannter Wetterzustand: \(symbolName), \(originalCondition) - verwende teilweise bewölkt als Fallback")
        return .partlyCloudy
    }
}
