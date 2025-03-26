import SwiftUI
import MapKit

struct Hotel: Identifiable {
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

struct Weather: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double
    let condition: WeatherCondition
    let location: String
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
}
