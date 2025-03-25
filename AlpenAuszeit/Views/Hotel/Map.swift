import SwiftUI
import MapKit

struct EnhancedMapView: View {
    let coordinates: CLLocationCoordinate2D
    let title: String
    
    var body: some View {
        Map(
            coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: coordinates,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                )
            ),
            annotationItems: [MapLocation(id: UUID(), name: title, coordinate: coordinates)]
        ) { location in
            MapMarker(coordinate: location.coordinate, tint: .red)
        }
        .mapStyle(.hybrid) // Satellitenansicht mit Straßenüberlagerung
        .mapControlVisibility(.hidden) // Versteckt Standardsteuerelemente
        .frame(height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// Hilfsstruct für die Annotation
struct MapLocation: Identifiable {
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D
}
