import SwiftUI
import MapKit

struct HotelListView: View {
    @ObservedObject var viewModel: HotelViewModel
    
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
                    Text("Hotels")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 70)
                        .foregroundColor(Color.white)
                    
                    Text("Tippen Sie auf ein Hotel für weitere Informationen")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .foregroundColor(Color.black)
                        .padding(.top, 90)
                    
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
struct HotelListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HotelListView(viewModel: HotelViewModel())
        }
    }
}
