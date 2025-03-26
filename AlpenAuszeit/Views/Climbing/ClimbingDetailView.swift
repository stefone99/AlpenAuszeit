import SwiftUI

struct ClimbingDetailView: View {
    let climbingRoute: ClimbingRoute
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(climbingRoute.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Schwierigkeitsgrad: \(climbingRoute.difficulty)")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Divider()
                
                // Höhenangaben
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Kletterlänge")
                            .font(.headline)
                        
                        Text(climbingRoute.climbingHeight)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Gesamthöhe")
                            .font(.headline)
                        
                        Text(climbingRoute.totalHeight)
                    }
                }
                
                Divider()
                
                // Zeitangaben
                Group {
                    Text("Zeitangaben")
                        .font(.headline)
                    
                    HStack {
                        InfoColumnView(title: "Kletterzeit", value: climbingRoute.climbingTime)
                        InfoColumnView(title: "Gesamtzeit", value: climbingRoute.totalTime)
                    }
                    
                    HStack {
                        InfoColumnView(title: "Zustiegszeit", value: climbingRoute.approachTime)
                        InfoColumnView(title: "Abstiegszeit", value: climbingRoute.descentTime)
                    }
                }
                
                Divider()
                
                Text("Beschreibung")
                    .font(.headline)
                
                Text(climbingRoute.character)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Klettersteig Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Hilfsfunktion für die strukturierte Anzeige der Zeit-Informationen
struct InfoColumnView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.body)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// Preview
struct ClimbingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClimbingDetailView(
                climbingRoute: ClimbingRoute(
                    name: "Maiklsteig",
                    difficulty: "A/B",
                    climbingHeight: "100 Hm",
                    totalHeight: "550 Hm",
                    climbingTime: "0:30 Min.",
                    totalTime: "3:00 Std.",
                    approachTime: "1:00 Std.",
                    descentTime: "1:30 Std.",
                    character: "Kurzer, steiler Steig durch die breite Felswand des Niederkaisers; ideal als Einstiegstour."
                )
            )
        }
    }
}
