import SwiftUI
import MapKit

struct HotelCard: View {
    let hotel: Hotel
    @ObservedObject var viewModel: HotelViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: hotel.images.first ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .frame(height: 150)
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(12, corners: [.topLeft, .topRight])
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(hotel.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    Text(hotel.location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(viewModel.formattedDateRange(for: hotel))
                        Spacer()
                        Text(hotel.boardType)
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            }
        }
    }
}
