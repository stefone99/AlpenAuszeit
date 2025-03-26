import SwiftUI
import CoreLocation

// LocationManager: Verwaltet die Standortberechtigungen und -aktualisierungen
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // Wetter braucht keine hohe Genauigkeit
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Standortberechtigungsstatus hat sich geändert
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        
        if manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    // Neuer Standort wurde empfangen
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        // Nur aktualisieren, wenn der Standort sich signifikant geändert hat oder noch nicht gesetzt wurde
        if location == nil || location!.distance(from: newLocation) > 5000 {  // 5 km
            location = newLocation
        }
        
        // Für Wetterdaten reicht eine einmalige Aktualisierung
        locationManager.stopUpdatingLocation()
    }
    
    // Fehler beim Empfangen des Standorts
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Standort-Fehler: \(error.localizedDescription)")
    }
    
    // Standortaktualisierung explizit anfordern (kann bei Bedarf aufgerufen werden)
    func requestLocation() {
        locationManager.requestLocation()
    }
}
