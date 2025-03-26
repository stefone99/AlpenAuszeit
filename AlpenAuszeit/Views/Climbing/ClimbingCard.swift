import SwiftUI

struct ClimbingCard: View {
    let climbingRoute: ClimbingRoute
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.orange.opacity(0.7), Color.red.opacity(0.4)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "figure.climbing")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    VStack(alignment: .leading) {
                        Text(climbingRoute.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Schwierigkeit: \(climbingRoute.difficulty)")
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
                        Text("Kletterlänge")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(climbingRoute.climbingHeight)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Kletterzeit")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(climbingRoute.climbingTime)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                
                Text(climbingRoute.character)
                    .font(.body)
                    .lineLimit(2)
                    .foregroundColor(.white)
                    .padding(.top, 5)
            }
            .padding()
        }
        .frame(height: 180)
    }
}
