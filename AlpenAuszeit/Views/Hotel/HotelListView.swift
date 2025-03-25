import SwiftUI
import MapKit

struct HotelListView: View {
    @ObservedObject var viewModel: HotelViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Unterkünfte")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ForEach(viewModel.hotels) { hotel in
                    NavigationLink(destination: HotelDetailView(hotel: hotel, viewModel: viewModel)) {
                        HotelCard(hotel: hotel, viewModel: viewModel)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Hotels")
    }
}
