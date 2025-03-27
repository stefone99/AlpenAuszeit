import SwiftUI
import MapKit

struct ClimbingDetailView: View {
    let climbingRoute: ClimbingRoute
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Titel und Schwierigkeit
                VStack(alignment: .leading, spacing: 5) {
                    Text(climbingRoute.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(climbingRoute.location)
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Text("Schwierigkeitsgrad: \(climbingRoute.difficulty)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                }
                
                Divider()
                
                // Höhenangaben
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Kletterlänge")
                            .font(.headline)
                        
                        Text(climbingRoute.climbingHeight)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Gesamthöhe")
                            .font(.headline)
                        
                        Text(climbingRoute.totalHeight)
                    }
                }
                
                Divider()
                
                // Zeitangaben
                Group {
                    Text("Zeitangaben")
                        .font(.headline)
                    
                    HStack {
                        InfoColumnView(title: "Kletterzeit", value: climbingRoute.climbingTime)
                        InfoColumnView(title: "Gesamtzeit", value: climbingRoute.totalTime)
                    }
                    
                    HStack {
                        InfoColumnView(title: "Zustiegszeit", value: climbingRoute.approachTime)
                        InfoColumnView(title: "Abstiegszeit", value: climbingRoute.descentTime)
                    }
                }
                
                Divider()
                
                // Beschreibung
                Text("Beschreibung")
                    .font(.headline)
                
                Text(climbingRoute.character)
                    .font(.body)
                
                Divider()
                
                // Topobild (anklickbar) - nun mit NavigationLink statt Sheet
                VStack(alignment: .leading, spacing: 8) {
                    Text("Topo")
                        .font(.headline)
                    
                    NavigationLink(destination: TopoDetailView(imageURL: climbingRoute.topoImageURL, routeName: climbingRoute.name)) {
                        VStack {
                            AsyncImage(url: climbingRoute.topoImageURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(8)
                                case .failure:
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            
                            Text("Zum Vergrößern tippen")
                                .font(.caption)
                                .foregroundColor(.blue)
                                .padding(.top, 4)
                        }
                    }
                }
                
                Divider()
                
                // Standortkarte
                VStack(alignment: .leading, spacing: 8) {
                    Text("Standort")
                        .font(.headline)
                    
                    // Standortkarte mit iOS 17 Syntax
                    Map(initialPosition: .region(MKCoordinateRegion(
                        center: climbingRoute.coordinates,
                        span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
                    ))) {
                        Marker(climbingRoute.name, coordinate: climbingRoute.coordinates)
                            .tint(.red)
                    }
                    .frame(height: 200)
                    .cornerRadius(12)
                    
                    Link(destination: URL(string: "maps://?ll=\(climbingRoute.coordinates.latitude),\(climbingRoute.coordinates.longitude)&q=\(climbingRoute.name)")!) {
                        Label("In Apple Maps öffnen", systemImage: "map")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Klettersteig Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Hilfsfunktion für die strukturierte Anzeige der Zeit-Informationen
struct InfoColumnView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// Eigenständige Topo-Detailansicht, jetzt als navigierbare View
struct TopoDetailView: View {
    let imageURL: URL
    let routeName: String
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.white)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(scale)
                            .offset(offset)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        let delta = value / lastScale
                                        lastScale = value
                                        // Begrenze die Skalierung auf 1x-5x
                                        scale = min(max(scale * delta, 1), 5)
                                    }
                                    .onEnded { _ in
                                        lastScale = 1.0
                                    }
                            )
                            .simultaneousGesture(
                                DragGesture()
                                    .onChanged { value in
                                        offset = CGSize(
                                            width: lastOffset.width + value.translation.width,
                                            height: lastOffset.height + value.translation.height
                                        )
                                    }
                                    .onEnded { _ in
                                        lastOffset = offset
                                    }
                            )
                            .onTapGesture(count: 2) {
                                // Doppeltipp zum Zurücksetzen
                                withAnimation {
                                    scale = 1.0
                                    offset = .zero
                                    lastOffset = .zero
                                }
                            }
                    case .failure:
                        VStack {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Text("Bild konnte nicht geladen werden")
                                .foregroundColor(.white)
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationTitle("Topo: \(routeName)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: "map")
                    Text("Topo Ansicht")
                }
                .foregroundColor(.white)
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.black, for: .navigationBar)
    }
}

// Preview
struct ClimbingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClimbingDetailView(
                climbingRoute: ClimbingRoute(
                    name: "Maiklsteig",
                    difficulty: "A/B",
                    climbingHeight: "100 Hm",
                    totalHeight: "550 Hm",
                    climbingTime: "0:30 Min.",
                    totalTime: "3:00 Std.",
                    approachTime: "1:00 Std.",
                    descentTime: "1:30 Std.",
                    character: "Kurzer, steiler Steig durch die breite Felswand des Niederkaisers; ideal als Einstiegstour.",
                    topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/import/topos/maiklsteig_st_johann_topo_0.jpg")!,
                    coordinates: CLLocationCoordinate2D(latitude: 47.537891767165114, longitude: 12.402658586736543),
                    location: "St. Johann in Tirol"
                )
            )
        }
    }
}
