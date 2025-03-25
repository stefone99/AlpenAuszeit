import SwiftUI

struct HikingCard: View {
    let hike: Hike
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(hike.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(hike.region)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Schwierigkeit")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(hike.difficulty)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Dauer")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(hike.duration)
                            .font(.headline)
                    }
                }
                
                Text(hike.description)
                    .font(.body)
                    .lineLimit(2)
                    .padding(.top, 5)
            }
            .padding()
        }
    }
}
