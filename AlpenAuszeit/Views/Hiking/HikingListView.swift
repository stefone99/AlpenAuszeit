import SwiftUI

struct HikingListView: View {
    @ObservedObject var viewModel: HikingViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Nur ein einleitender Text, kein Haupttitel mehr
                Text("Entdecken Sie die schönsten Wanderungen in Tirol")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                ForEach(viewModel.hikes) { hike in
                    NavigationLink(destination: HikingDetailView(hike: hike)) {
                        HikingCard(hike: hike)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.vertical)
        }
    }
}
