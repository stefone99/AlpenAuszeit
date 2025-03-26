import SwiftUI

struct TripListView: View {
    @ObservedObject var viewModel: TripViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Tippen Sie auf eine Fahrt für Details")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                ForEach(viewModel.trips) { trip in
                    NavigationLink(destination: TripDetailView(trip: trip, viewModel: viewModel)) {
                        TripCard(trip: trip, viewModel: viewModel)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.vertical)
        }
    }
}
