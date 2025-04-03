import SwiftUI

struct ClimbingListView: View {
    @ObservedObject var viewModel: ClimbingViewModel
    
    // Einstellbare Parameter für den Halbkreis
    private let circleHeight: CGFloat = 100       // Höhe des Kreisrahmens
    private let circleRadiusFactor: CGFloat = 1.85  // Faktor für den Radius (größer = breiter)
    private let circleYOffset: CGFloat = -525     // Negative Werte schieben nach oben
    
    var body: some View {
        ScrollView {
            // ZStack mit dem Halbkreis als erstes Element
            ZStack(alignment: .top) {
                // 1. Halbkreis im Hintergrund
                SemicircleShape(radiusFactor: circleRadiusFactor)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.5)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: circleHeight)
                    .offset(y: circleYOffset)
                    .edgesIgnoringSafeArea(.top)
                
                // 2. Der ursprüngliche Inhalt
                VStack(alignment: .leading, spacing: 20) {
                    Text("Klettersteige")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 70)
                        .foregroundColor(Color.white)
                    
                    Text("Entdecken Sie die besten Klettersteige in der Region")
                        .font(.subheadline)
                        .padding(.horizontal)
                        .foregroundColor(Color.black)
                        .padding(.top, 90)
                    
                    // Gruppiere die Klettersteige nach Standort mit benutzerdefinierter Sortierung
                    let locations = viewModel.routesByLocation().keys.sorted {
                        viewModel.locationSortOrder($0) < viewModel.locationSortOrder($1)
                    }
                    
                    ForEach(locations, id: \.self) { location in
                        if let routes = viewModel.routesByLocation()[location] {
                            VStack(alignment: .leading, spacing: 15) {
                                // Ortsname als Überschrift (nur einmal pro Ort)
                                Text(location)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                
                                // Alle Klettersteige an diesem Ort
                                ForEach(routes) { climbingRoute in
                                    NavigationLink(destination: ClimbingDetailView(climbingRoute: climbingRoute)) {
                                        ClimbingCard(climbingRoute: climbingRoute)
                                            .padding(.horizontal)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline) // Navigationstitel verkleinern
        .toolbar {
            ToolbarItem(placement: .principal) {
                // Leeres Element für den Titel-Bereich, um den Standard-Titel zu überschreiben
                Text("").font(.caption)
            }
        }
    }
}

// Preview
struct ClimbingListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClimbingListView(viewModel: ClimbingViewModel())
        }
    }
}
