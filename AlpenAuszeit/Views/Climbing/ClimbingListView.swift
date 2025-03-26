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
                
                ForEach(viewModel.climbingRoutes) { climbingRoute in
                    NavigationLink(destination: ClimbingDetailView(climbingRoute: climbingRoute)) {
                        ClimbingCard(climbingRoute: climbingRoute)
                            .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
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
