import SwiftUI

struct ClimbingListView: View {
    @ObservedObject var viewModel: ClimbingViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Entdecken Sie die besten Klettersteige in der Region")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
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
}

// Preview
struct ClimbingListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClimbingListView(viewModel: ClimbingViewModel())
        }
    }
}
