import SwiftUI

// Eine dedizierte View für die Anfrage nach Standortberechtigung
struct PermissionRequestView: View {
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        ZStack {
            // Hintergrundverdunklung
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Image(systemName: "location.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Standortberechtigung")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Die App benötigt Zugriff auf Ihren Standort, um aktuelle Wetterdaten für Ihren Aufenthaltsort anzuzeigen.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button(action: {
                    // Explizit die Standortberechtigung anfordern
                    print("App: Standortberechtigung per Button angefordert")
                    locationManager.requestWhenInUseAuthorization()
                }) {
                    Text("Standort freigeben")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
            )
            .padding(30)
        }
        .onAppear {
            // Sofort bei Erscheinen die Berechtigungsanfrage anzeigen
            print("PermissionRequestView: View erschienen, fordere Standortberechtigung an")
        }
    }
}

// Vorschau für den PermissionRequestView
struct PermissionRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionRequestView(locationManager: LocationManager())
    }
}
