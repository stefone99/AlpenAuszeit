import SwiftUI
import WebKit

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
                
                NavigationLink(destination: BergfexFullView(url: hike.infoLink, hikeName: hike.name)) {
                    HStack {
                        Image(systemName: "safari")
                        Text("Bergfex Informationen anzeigen")
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

// Separate Vollbildansicht für Bergfex-Inhalte als eigenständige Ansicht in der Navigation
struct BergfexFullView: View {
    let url: URL
    let hikeName: String
    
    var body: some View {
        WebView(url: url)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Bergfex: \(hikeName)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "mountain.2")
                        Text("Bergfex")
                    }
                }
            }
    }
}
