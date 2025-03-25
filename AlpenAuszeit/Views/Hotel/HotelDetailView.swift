import SwiftUI
import MapKit

struct HotelDetailView: View {
    let hotel: Hotel
    @ObservedObject var viewModel: HotelViewModel
    @State private var selectedImageIndex = 0
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Bildkarussell
                TabView(selection: $selectedImageIndex) {
                    ForEach(0..<hotel.images.count, id: \.self) { index in
                        AsyncImage(url: URL(string: hotel.images[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 300)
                .onReceive(timer) { _ in
                    withAnimation {
                        selectedImageIndex = (selectedImageIndex + 1) % hotel.images.count
                    }
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(hotel.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(hotel.location)
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Check-in")
                                .font(.headline)
                            Text(viewModel.formattedDate(from: hotel.checkIn))
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Check-out")
                                .font(.headline)
                            Text(viewModel.formattedDate(from: hotel.checkOut))
                        }
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Verpflegung")
                            .font(.headline)
                        Text(hotel.boardType)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Standort")
                            .font(.headline)
                        
                        Map(coordinateRegion: .constant(MKCoordinateRegion(
                            center: hotel.coordinates,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )), annotationItems: [hotel]) { hotel in
                            MapMarker(coordinate: hotel.coordinates, tint: .red)
                        }
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Button(action: {
                            UIApplication.shared.open(hotel.mapLink)
                        }) {
                            HStack {
                                Image(systemName: "map")
                                Text("In Google Maps öffnen")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Hoteldetails")
        .navigationBarTitleDisplayMode(.inline)
    }
}
