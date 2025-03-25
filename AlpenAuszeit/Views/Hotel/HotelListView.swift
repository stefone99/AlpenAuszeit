import SwiftUI
import MapKit

struct HotelListView: View {
    @ObservedObject var viewModel: HotelViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Tippen Sie auf ein Hotel für weitere Informationen")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.hotels) { hotel in
                        NavigationLink(destination: HotelDetailView(hotel: hotel, viewModel: viewModel)) {
                            HotelCard(hotel: hotel, viewModel: viewModel)
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 8)
            }
            .padding(.vertical)
        }
    }
}
