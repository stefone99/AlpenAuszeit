import SwiftUI

struct ViennaActivityListView: View {
    @StateObject private var viewModel = ViennaActivityViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(ViennaActivityCategory.allCases, id: \.self) { category in
                    if let activities = viewModel.activitiesByCategory()[category] {
                        VStack(alignment: .leading, spacing: 10) {
                            // Kategorie-Header
                            HStack(spacing: 10) {
                                Image(systemName: category.icon)
                                    .font(.title2)
                                    .foregroundColor(category.color)
                                
                                Text(category.rawValue)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal)
                            
                            // Aktivitäten der aktuellen Kategorie
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(activities) { activity in
                                        NavigationLink(destination: ViennaActivityDetailView(activity: activity)) {
                                            ViennaActivityCard(activity: activity)
                                                .frame(width: 260, height: 230)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Aktivitäten in Wien")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ViennaActivityCard: View {
    let activity: ViennaActivity
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Container für das Bild mit Abrundung
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 5)
                .overlay(
                    // Bild
                    ZStack {
                        // Hintergrundfarbe für den Ladevorgang
                        Rectangle()
                            .fill(activity.category.color.opacity(0.2))
                        
                        // Bild laden
                        if let imageURL = activity.imageURL {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                case .failure:
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundColor(activity.category.color)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                )
            
            // Text-Overlay mit Gradient
            VStack(alignment: .leading, spacing: 4) {
                Text(activity.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                // Beschreibungstext entfernt
            }
            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.25)]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            .padding(.bottom, 0) // Überlappung mit dem Hauptcontainer
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// Erweiterung für abgerundete Ecken in verschiedenen Richtungen
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ViennaActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ViennaActivityListView()
        }
    }
}
