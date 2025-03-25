import SwiftUI

struct TripListView: View {
    @ObservedObject var viewModel: TripViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Fahrten")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(viewModel.trips) { trip in
                    TripCard(trip: trip, viewModel: viewModel)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Fahrten")
    }
}
