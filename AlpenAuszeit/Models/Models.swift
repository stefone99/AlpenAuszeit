import SwiftUI
import MapKit

struct Hotel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let location: String
    let checkIn: Date
    let checkOut: Date
    let checkInTime: String
    let checkOutTime: String
    let boardType: String
    let mapLink: URL
    let images: [String]
    let coordinates: CLLocationCoordinate2D
    
    // Implementierung von Equatable
    static func == (lhs: Hotel, rhs: Hotel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Trip: Identifiable {
    let id = UUID()
    let date: Date
    let departureTime: String
    let arrivalTime: String
    let from: String
    let to: String
    let stations: [TripStation]
}

struct TripStation: Identifiable {
    let id = UUID()
    let time: String
    let location: String
    let platform: String
    let isTransfer: Bool
}

struct Hike: Identifiable {
    let id = UUID()
    let name: String
    let region: String
    let infoLink: URL
    let difficulty: String
    let duration: String
    let description: String
}

// Korrigierte Weather-Struktur ohne doppelte id-Initialisierung

struct Weather: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double     // Aktuelle Temperatur / oder Tageswert für Vorhersage
    let highTemperature: Double // Höchsttemperatur
    let lowTemperature: Double  // Niedrigsttemperatur
    let condition: WeatherCondition
    let location: String
    
    // Initialisierer mit Standardwerten für die neuen Felder
    init(date: Date, temperature: Double, condition: WeatherCondition, location: String,
         highTemperature: Double? = nil, lowTemperature: Double? = nil) {
        self.date = date
        self.temperature = temperature
        self.condition = condition
        self.location = location
        self.highTemperature = highTemperature ?? temperature
        self.lowTemperature = lowTemperature ?? temperature
    }
}

enum WeatherCondition: String {
    case sunny = "sun.max"
    case cloudy = "cloud"
    case rainy = "cloud.rain"
    case snowy = "cloud.snow"
    case partlyCloudy = "cloud.sun"
    
    var description: String {
        switch self {
        case .sunny: return "Sonnig"
        case .cloudy: return "Bewölkt"
        case .rainy: return "Regen"
        case .snowy: return "Schnee"
        case .partlyCloudy: return "Teilweise bewölkt"
        }
    }
    
    // Optimiert für Apple SF Symbols, die von WeatherKit verwendet werden
    var iconName: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .cloudy: return "cloud.fill"
        case .rainy: return "cloud.rain.fill"
        case .snowy: return "cloud.snow.fill"
        case .partlyCloudy: return "cloud.sun.fill"
        }
    }
    
    // Rückgabe eines alternativen Icons, falls erwünscht
    func alternativeIcon(for temperature: Double) -> String {
        switch self {
        case .sunny:
            return temperature > 25 ? "sun.max.fill" : "sun.max"
        case .cloudy:
            return "cloud.fill"
        case .rainy:
            return temperature < 5 ? "cloud.sleet.fill" : "cloud.rain.fill"
        case .snowy:
            return "cloud.snow.fill"
        case .partlyCloudy:
            return temperature > 25 ? "cloud.sun.fill" : "cloud.sun"
        }
    }
    
    // Statische Hilfsmethode, um aus einem WeatherKit-Symbol die richtige Bedingung abzuleiten
    static func fromWeatherKitSymbol(_ symbolName: String, temperature: Double) -> WeatherCondition {
        if temperature < 3 && (symbolName.contains("snow") || symbolName.contains("sleet")) {
            return .snowy
        }
        
        if symbolName.contains("sun.max") || symbolName.contains("clear") {
            return .sunny
        }
        else if symbolName.contains("cloud.sun") || symbolName.contains("partly-cloudy") {
            return .partlyCloudy
        }
        else if (symbolName.contains("cloud") && !symbolName.contains("rain") && !symbolName.contains("snow")) {
            return .cloudy
        }
        else if symbolName.contains("rain") || symbolName.contains("drizzle") {
            return .rainy
        }
        else {
            // Fallback für unbekannte Symbole
            return .partlyCloudy
        }
    }
}

// Neue Struktur für Klettersteige
struct ClimbingRoute: Identifiable {
    let id = UUID()
    let name: String
    let difficulty: String
    let climbingHeight: String
    let totalHeight: String
    let climbingTime: String
    let totalTime: String
    let approachTime: String
    let descentTime: String
    let character: String
    let topoImageURL: URL // Topografiebild
    let coordinates: CLLocationCoordinate2D // Standort für die Karte
    let location: String // Ortsname
    let infoLink: URL? // Bergfex-Link
}
