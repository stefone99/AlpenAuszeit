import SwiftUI
import MapKit

struct EnhancedMapView: View {
    let coordinates: CLLocationCoordinate2D  // Fallback-Koordinaten
    let title: String                        // Hotelname
    let location: String                     // Ort (Wien, St. Johann, etc.)
    
    @State private var selectedMapType: MapDisplayType = .satellite
    @State private var searchResult: MKMapItem?
    @State private var isSearching = true
    @State private var annotationItems: [MapLocation] = []
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var searchQuery: String {
        "\(title) \(location)"
    }
    
    // Konvertiere unseren benutzerdefinierten Typ in einen MapStyle
    private func getMapStyle() -> MapStyle {
        switch selectedMapType {
        case .standard:
            return .standard
        case .satellite:
            return .hybrid(elevation: .realistic, pointsOfInterest: .all)
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            if isSearching {
                // Ladeansicht während der Suche
                ProgressView("Suche Hotel...")
                    .frame(height: 270)
            } else {
                // Kartenansicht mit dem gefundenen Standort
                Map(position: $cameraPosition, selection: .constant(nil)) {
                    ForEach(annotationItems) { item in
                        // Marker für jeden Standort
                        Marker(item.name, coordinate: item.coordinate)
                            .tint(.red)
                    }
                }
                .mapStyle(getMapStyle())
                .mapControlVisibility(.visible)
                .frame(height: 270)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            // Vereinfachter Kartentyp-Umschalter
            Picker("Kartenansicht", selection: $selectedMapType) {
                ForEach(MapDisplayType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 4)
        }
        .onAppear {
            // Zuerst Fallback-Annotation setzen, damit sofort etwas sichtbar ist
            setupFallbackAnnotation()
            
            // Dann die Suche starten
            searchForHotel()
        }
    }
    
    // Setzt die Fallback-Annotation, damit sofort ein Pin sichtbar ist
    private func setupFallbackAnnotation() {
        let fallbackLocation = MapLocation(id: UUID(), name: title, coordinate: coordinates)
        annotationItems = [fallbackLocation]
        cameraPosition = .region(MKCoordinateRegion(
            center: coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        ))
    }
    
    // Durchführung der Hotelsuche
    private func searchForHotel() {
        isSearching = true
        
        // Erstelle eine Suchanfrage mit dem Hotelnamen und Ort
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchQuery
        searchRequest.region = MKCoordinateRegion(
            center: coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        
        // Führe die Suche durch
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let error = error {
                print("Fehler bei der Hotelsuche: \(error.localizedDescription)")
                // Bei Fehler Fallback-Annotation beibehalten und Suche beenden
                isSearching = false
                return
            }
            
            // Nehme das erste Ergebnis, wenn verfügbar
            if let firstResult = response?.mapItems.first {
                // Erstelle ein neues Annotations-Item mit dem gefundenen Ergebnis
                let foundLocation = MapLocation(
                    id: UUID(),
                    name: firstResult.name ?? title,
                    coordinate: firstResult.placemark.coordinate
                )
                
                // Aktualisiere die Annotation
                annotationItems = [foundLocation]
                
                // Setze die Kameraposition auf den gefundenen Standort
                cameraPosition = .region(MKCoordinateRegion(
                    center: firstResult.placemark.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                ))
                
                print("Hotel gefunden: \(firstResult.name ?? "Unbekannt") an \(firstResult.placemark.coordinate)")
            }
            
            // Suche beenden, unabhängig vom Ergebnis
            isSearching = false
        }
    }
}

// Eine hashbare Enum für unsere Kartentypen
enum MapDisplayType: String, Hashable, CaseIterable {
    case standard = "Standard"
    case satellite = "Satellit"
}

// Hilfsstruct für die Annotation
struct MapLocation: Identifiable {
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D
}
