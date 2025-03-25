import SwiftUI

struct TripCard: View {
    let trip: Trip
    @ObservedObject var viewModel: TripViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text(viewModel.formattedDate(for: trip))
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "train.side.front.car")
                        .foregroundColor(.blue)
                }
                
                Divider()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(trip.departureTime)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(trip.from)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text(trip.arrivalTime)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(trip.to)
                            .font(.subheadline)
                    }
                }
            }
            .padding()
        }
    }
}
