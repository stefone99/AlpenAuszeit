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
}
