import SwiftUI

struct HikingCard: View {
    let hike: Hike
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green.opacity(0.7), Color.blue.opacity(0.4)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "mountain.2")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        Text(hike.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(hike.region)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Divider()
                    .background(Color.white.opacity(0.5))
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Schwierigkeit")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        HStack {
                            Image(systemName: difficultyIcon(for: hike.difficulty))
                            Text(hike.difficulty)
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Dauer")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        HStack {
                            Text(hike.duration)
                                .font(.headline)
                            Image(systemName: "clock")
                        }
                        .foregroundColor(.white)
                    }
                }
                
                Text(hike.description)
                    .font(.body)
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .padding(.top, 5)
            }
            .padding()
        }
        .frame(height: 180)
    }
    
    // Hilfsfunktion für verschiedene Icons je nach Schwierigkeit
    private func difficultyIcon(for difficulty: String) -> String {
        switch difficulty.lowercased() {
        case _ where difficulty.lowercased().contains("leicht"):
            return "figure.walk"
        case _ where difficulty.lowercased().contains("mittel"):
            return "figure.hiking"
        case _ where difficulty.lowercased().contains("schwer"):
            return "figure.climbing"
        default:
            return "figure.hiking"
        }
    }
}
