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
                            Text("ab \(hotel.checkInTime) Uhr")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Check-out")
                                .font(.headline)
                            Text(viewModel.formattedDate(from: hotel.checkOut))
                            Text("bis \(hotel.checkOutTime) Uhr")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
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
                        
                        // Verbesserte Kartenansicht mit Interaktionen
                                                EnhancedMapView(
                                                    coordinates: hotel.coordinates,
                                                    title: hotel.name,
                                                    location: hotel.location
                                                )
                        
                        // Button für Wien-Aktivitäten (nur anzeigen, wenn das Hotel in Wien ist)
                        if hotel.location == "Wien" {
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Divider()
                                
                                Text("Aktivitäten in Wien")
                                    .font(.headline)
                                
                                NavigationLink(destination: ViennaActivityListView()) {
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse")
                                        Text("Jetzt entdecken")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("activity_button"))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                .padding(.bottom, 15)
                            }
                            .padding(.top, 10)
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

struct HotelDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HotelDetailView(
                hotel: Hotel(
                    name: "Flemings Selection Hotel Wien-City",
                    location: "Wien",
                    checkIn: Date(),
                    checkOut: Date().addingTimeInterval(86400 * 2),
                    checkInTime: "15:00",
                    checkOutTime: "11:00",
                    boardType: "Frühstück",
                    mapLink: URL(string: "https://maps.apple.com")!,
                    images: ["https://example.com/image.jpg"],
                    coordinates: CLLocationCoordinate2D(latitude: 48.2082, longitude: 16.3738)
                ),
                viewModel: HotelViewModel()
            )
        }
    }
}
