import SwiftUI
import MapKit

// Hilfsstruct für die Annotation
struct MapLocation: Identifiable {
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D
}

// Eine hashable Enum für unsere Kartentypen
enum MapDisplayType: String, Hashable, CaseIterable {
    case standard = "Standard"
    case satellite = "Satellit"
    case hybrid3D = "3D-Satellit"
}

// Verbesserte Kartenansicht mit Interaktionen und Kartentyp-Umschalter
struct EnhancedMapView: View {
    let coordinates: CLLocationCoordinate2D
    let title: String
    @State private var selectedMapType: MapDisplayType = .hybrid3D
    
    // Konvertiere unseren benutzerdefinierten Typ in einen MapStyle
    private func getMapStyle() -> MapStyle {
        switch selectedMapType {
        case .standard:
            return .standard
        case .satellite:
            return .hybrid(elevation: .realistic, pointsOfInterest: .all)
        case .hybrid3D:
            return .hybrid(elevation: .realistic, pointsOfInterest: .all, showsTraffic: true)
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // Karte mit voller Interaktivität
            Map(initialPosition: .camera(MapCamera(
                centerCoordinate: coordinates,
                distance: 600,
                heading: 0,
                pitch: 45
            ))) {
                Marker(title, coordinate: coordinates)
                    .tint(.red)
            }
            .mapStyle(getMapStyle())
            // Kontrollelemente anzeigen, damit der Benutzer zoomen kann
            .mapControlVisibility(.visible)
            // Interaktionen werden automatisch aktiviert in iOS 17
            .frame(height: 270)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // Kartentyp-Umschalter
            Picker("Kartenansicht", selection: $selectedMapType) {
                ForEach(MapDisplayType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 4)
        }
    }
}
