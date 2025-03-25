import SwiftUI

struct HikingDetailView: View {
    let hike: Hike
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(hike.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(hike.region)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Divider()
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Schwierigkeit")
                            .font(.headline)
                        
                        Text(hike.difficulty)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Dauer")
                            .font(.headline)
                        
                        Text(hike.duration)
                    }
                }
                
                Divider()
                
                Text("Beschreibung")
                    .font(.headline)
                
                Text(hike.description)
                    .font(.body)
                
                Divider()
                
                // Bergfex Einbettung (in einer echten App würde hier ein WebView verwendet)
                Link(destination: hike.infoLink) {
                    HStack {
                        Image(systemName: "safari")
                        Text("Auf Bergfex ansehen")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding()
        }
        .navigationTitle("Wanderdetails")
        .navigationBarTitleDisplayMode(.inline)
    }
}
