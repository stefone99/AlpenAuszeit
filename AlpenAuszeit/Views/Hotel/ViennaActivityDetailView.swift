import SwiftUI

struct ViennaActivityDetailView: View {
    let activity: ViennaActivity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Bild
                if let imageURL = activity.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Rectangle()
                                    .fill(activity.category.color.opacity(0.2))
                                    .frame(height: 250)
                                    .cornerRadius(16)
                                ProgressView()
                            }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxHeight: 450)
                                .clipped()
                        case .failure:
                            ZStack {
                                Rectangle()
                                    .fill(activity.category.color.opacity(0.2))
                                    .frame(height: 250)
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(activity.category.color)
                            }
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                // Inhalt
                VStack(alignment: .leading, spacing: 20) {
                    // Titel und Kategorie
                    VStack(alignment: .leading, spacing: 8) {
                        Text(activity.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 8) {
                            Image(systemName: activity.category.icon)
                                .foregroundColor(activity.category.color)
                            
                            Text(activity.category.rawValue)
                                .foregroundColor(activity.category.color)
                                .font(.subheadline)
                        }
                    }
                    
                    Divider()
                    
                    // Beschreibung
                    Text("Beschreibung")
                        .font(.headline)
                    
                    Text(activity.description)
                        .lineSpacing(5)
                    
                    // Kein Aktionsbutton mehr
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ViennaActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ViennaActivityDetailView(
                activity: ViennaActivity(
                    name: "Schloss Schönbrunn",
                    description: "In den original eingerichteten kaiserlichen Prunk- und Wohnräumen erhalten Sie einen Einblick in das Leben von Maria Theresia, Kaiser Franz Joseph und Kaiserin Elisabeth, die auch als Sisi bekannt ist.",
                    imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-2.png"),
                    category: .artCulture
                )
            )
        }
    }
}
