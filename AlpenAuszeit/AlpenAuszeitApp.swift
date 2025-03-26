import SwiftUI

@main
struct AlpenAuszeitApp: App {
    // LocationManager als StateObject initialisieren
    @StateObject private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .onAppear {
                    // Bei App-Start direkt die Standortberechtigung anfordern
                    // Dies löst den nativen iOS-Berechtigungsdialog aus
                    print("App: App wurde gestartet, fordere Standortberechtigung an")
                    locationManager.requestWhenInUseAuthorization()
                }
        }
    }
}
