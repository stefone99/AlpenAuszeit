import SwiftUI
import CoreLocation

// LocationManager: Verwaltet die Standortberechtigungen und -aktualisierungen
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation? {
        didSet {
            print("LocationManager: Standort aktualisiert - location ist nun \(location?.coordinate.latitude ?? 0), \(location?.coordinate.longitude ?? 0)")
        }
    }
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var lastError: String?
    
    // Standard-Standort (Wien) für den Fall, dass kein Standort verfügbar ist
    private let defaultLocation = CLLocation(latitude: 48.2082, longitude: 16.3738)
    
    override init() {
        super.init()
        
        // Konfigurieren des LocationManagers
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer  // Wetter braucht keine hohe Genauigkeit
        
        print("LocationManager: Initialisiert")
        
        // Sofort Fallback-Standort setzen
        location = defaultLocation
        print("LocationManager: Fallback-Standort (Wien) als Standardwert gesetzt")
        
        // Aktuellen Berechtigungsstatus speichern
        authorizationStatus = locationManager.authorizationStatus
        print("LocationManager: Initialer Berechtigungsstatus: \(authorizationStatus)")
        
        // Standortberechtigungen sofort anfordern
        requestWhenInUseAuthorization()
    }
    
    // Direkte Methode zum Anfordern der "when in use" Berechtigung
    func requestWhenInUseAuthorization() {
        print("LocationManager: WhenInUse-Berechtigung direkt angefordert")
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Standortberechtigungsstatus hat sich geändert
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        print("LocationManager: Berechtigungsstatus geändert: \(authorizationStatus)")
        
        if manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways {
            print("LocationManager: Berechtigung erhalten, starte Standortaktualisierung")
            locationManager.startUpdatingLocation()
        } else {
            print("LocationManager: Keine Berechtigung erhalten: \(authorizationStatus)")
            
            // Sicherstellen, dass wir einen Fallback-Standort haben
            if location == nil {
                location = defaultLocation
                print("LocationManager: Fallback-Standort (Wien) gesetzt wegen Berechtigungsstatus \(authorizationStatus)")
            }
        }
    }
    
    // Neuer Standort wurde empfangen
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            print("LocationManager: Leere Standortliste erhalten")
            return
        }
        
        print("LocationManager: Neuer Standort empfangen: \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
        
        // Nur aktualisieren, wenn der Standort sich signifikant geändert hat oder noch nicht gesetzt wurde
        // Für den Fall des Offiziellen WeatherKit wollen wir den echten Standort verwenden
        location = newLocation
        print("LocationManager: Standort aktualisiert auf echte Position")
        
        // Für Wetterdaten reicht eine einmalige Aktualisierung
        locationManager.stopUpdatingLocation()
        print("LocationManager: Standortaktualisierung gestoppt")
    }
    
    // Fehler beim Empfangen des Standorts
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager: Standort-Fehler: \(error.localizedDescription)")
        lastError = error.localizedDescription
        
        // Bei jedem Fehler den Fallback-Standort setzen, falls noch keiner gesetzt ist
        if location == nil {
            print("LocationManager: Setze Fallback-Standort (Wien) wegen Fehler")
            location = defaultLocation
        }
    }
    
    // Standortaktualisierung explizit anfordern
    func requestLocation() {
        print("LocationManager: Explizite Standortanforderung")
        
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            locationManager.requestLocation()
            print("LocationManager: Standortanforderung gesendet")
        } else {
            print("LocationManager: Keine Berechtigung für Standortanforderung: \(authorizationStatus)")
            
            // Frage erneut nach Berechtigung, falls noch nicht bestimmt
            if authorizationStatus == .notDetermined {
                print("LocationManager: Erneute Anfrage nach Standortberechtigung")
                locationManager.requestWhenInUseAuthorization()
            } else {
                // Bei Ablehnung zeigen wir eine Meldung in der UI über lastError
                lastError = "Bitte erlauben Sie den Standortzugriff in den Einstellungen für korrekte Wetterdaten."
            }
            
            // Fallback-Standort verwenden
            if location == nil {
                location = defaultLocation
                print("LocationManager: Fallback-Standort (Wien) gesetzt, da keine Berechtigung für Anforderung")
            }
        }
    }
    
    // Hilfsmethode, die den aktuellen oder Fallback-Standort zurückgibt
    func getCurrentOrDefaultLocation() -> CLLocation {
        return location ?? defaultLocation
    }
}
