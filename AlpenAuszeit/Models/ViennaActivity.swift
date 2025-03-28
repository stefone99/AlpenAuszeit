import SwiftUI

// Modell für Wiener Aktivitäten
struct ViennaActivity: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageURL: URL?
    let category: ViennaActivityCategory
}

// Enum für die verschiedenen Kategorien
enum ViennaActivityCategory: String, CaseIterable {
    case activitiesExcursions = "Aktivitäten & Ausflüge"
    case artCulture = "Kunst & Kultur"
    case barsCafes = "Bars & Cafés"
    case culinary = "Kulinarik"
    case discoverRelax = "Entdecken & Auszeit"
    case shopping = "Shopping"
    case nightlife = "Nachtleben"
    
    var icon: String {
        switch self {
        case .activitiesExcursions:
            return "figure.hiking"
        case .artCulture:
            return "building.columns"
        case .barsCafes:
            return "cup.and.saucer"
        case .culinary:
            return "fork.knife"
        case .discoverRelax:
            return "leaf"
        case .shopping:
            return "bag"
        case .nightlife:
            return "moon.stars"
        }
    }
    
    var color: Color {
        switch self {
        case .activitiesExcursions:
            return .blue
        case .artCulture:
            return .purple
        case .barsCafes:
            return .brown
        case .culinary:
            return .orange
        case .discoverRelax:
            return .green
        case .shopping:
            return .pink
        case .nightlife:
            return .indigo
        }
    }
}
