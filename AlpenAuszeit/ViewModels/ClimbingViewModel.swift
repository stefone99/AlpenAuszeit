import SwiftUI
import CoreLocation

class ClimbingViewModel: ObservableObject {
    @Published var climbingRoutes: [ClimbingRoute] = []
    
    init() {
        setupClimbingRoutes()
    }
    
    func setupClimbingRoutes() {
        climbingRoutes = [
            ClimbingRoute(
                name: "Maiklsteig",
                difficulty: "A/B",
                climbingHeight: "100 Hm",
                totalHeight: "550 Hm",
                climbingTime: "0:30 Min.",
                totalTime: "3:00 Std.",
                approachTime: "1:00 Std.",
                descentTime: "1:30 Std.",
                character: "Kurzer, steiler Steig durch die breite Felswand des Niederkaisers; ideal als Einstiegstour.",
                topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/import/topos/maiklsteig_st_johann_topo_0.jpg")!,
                coordinates: CLLocationCoordinate2D(latitude: 47.537891767165114, longitude: 12.402658586736543),
                location: "St. Johann in Tirol",
                infoLink: URL(string: "https://www.bergfex.at/sommer/tirol/touren/wanderung/3789911,maiklsteig/")
            ),
            ClimbingRoute(
                name: "Übungsklettersteig Ellmau",
                difficulty: "B/C",
                climbingHeight: "50 Hm",
                totalHeight: "350 Hm",
                climbingTime: "0:15 Min.",
                totalTime: "1:35 Std.",
                approachTime: "0:40 Min.",
                descentTime: "0:40 Min.",
                character: "Kurzweiliges Übungserlebnis an einem kleinen Felsblock; kombinierbar mit Aufstieg zum Baumgartenkopf.",
                topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/import/topos/uebungsklettersteig_ellmau_topo.jpg")!,
                coordinates: CLLocationCoordinate2D(latitude: 47.54121833989156, longitude: 12.319629724330536),
                location: "Ellmau",
                infoLink: URL(string: "https://www.bergfex.at/sommer/tirol/touren/wanderung/3790122,elmau-uebungsklettersteig/")
            ),
            ClimbingRoute(
                name: "Adolari Klettersteig",
                difficulty: "B/C",
                climbingHeight: "60 Hm",
                totalHeight: "100 Hm",
                climbingTime: "0:45 Min.",
                totalTime: "1:15 Std.",
                approachTime: "0:15 Min.",
                descentTime: "0:15 Min.",
                character: "Kurzer Steig oberhalb des Kirchleins St. Adolari, der an einem Klettergarten vorbeiführt; auch bei unsicherem Wetter interessant.",
                topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/import/topos/adolari_klettersteig_topo_0.png")!,
                coordinates: CLLocationCoordinate2D(latitude: 47.55617267425543, longitude: 12.564997482001065),
                location: "St. Ulrich am Pillersee",
                infoLink: nil // Kein Link für Adolari vorhanden
            ),
            ClimbingRoute(
                name: "Zahme Gams Klettersteig",
                difficulty: "B/C",
                climbingHeight: "110 Hm",
                totalHeight: "140 Hm",
                climbingTime: "0:35 Min.",
                totalTime: "1:05 Std.",
                approachTime: "0:10 Min.",
                descentTime: "0:20 Min.",
                character: "Lohnender Anfängerstieg in Weißbach bei Lofer, verläuft im AV-Klettergarten – familienfreundlich.",
                topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/tour/bilder/zahme-gams-klettersteig-topo.png")!,
                coordinates: CLLocationCoordinate2D(latitude: 47.52336094735768, longitude: 12.753019355586636),
                location: "Weißbach bei Lofer",
                infoLink: URL(string: "https://www.bergfex.at/sommer/salzburg/touren/wanderung/3790225,gamsklettersteige/")
            ),
            ClimbingRoute(
                name: "Gams Kitz Klettersteig",
                difficulty: "B",
                climbingHeight: "90 Hm",
                totalHeight: "100 Hm",
                climbingTime: "0:30 Min.",
                totalTime: "1:00 Std.",
                approachTime: "0:10 Min.",
                descentTime: "0:20 Min.",
                character: "Klassischer Einsteigersteig in Weißbach bei Lofer, ideal um erste Erfahrungen mit Stahlseilen zu sammeln.",
                topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/tour/topo/23537/gams-kitz-klettersteig-weissbach-lofer-topo.png")!,
                coordinates: CLLocationCoordinate2D(latitude: 47.51972849164876, longitude: 12.756540497916387),
                location: "Weißbach bei Lofer",
                infoLink: URL(string: "https://www.bergfex.at/sommer/salzburg/touren/wanderung/3790225,gamsklettersteige/")
            ),
            ClimbingRoute(
                name: "Grünstein Klettersteig mit Var. Isidor",
                difficulty: "C (Var. D/E)",
                climbingHeight: "470 Hm",
                totalHeight: "750 Hm",
                climbingTime: "3:00 Std.",
                totalTime: "5:00 Std.",
                approachTime: "0:45 Min.",
                descentTime: "1:15 Std.",
                character: "Anspruchsvoller Steig über dem Königssee mit mehreren Varianten, spektakulären Aussichten und technisch fordernden Passagen.",
                topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/tour/topo/7778/gruenstein_klettersteig_topo.png")!,
                coordinates: CLLocationCoordinate2D(latitude: 47.591545233318186, longitude: 12.972755230891455),
                location: "Schönau am Königssee",
                infoLink: URL(string: "https://www.bergfex.at/sommer/bayern/touren/wanderung/3790232,gruenstein-klettersteig/")
            ),
            ClimbingRoute(
                name: "Schützensteig Klettersteig – Jenner",
                difficulty: "B",
                climbingHeight: "60 Hm",
                totalHeight: "570 Hm",
                climbingTime: "0:30 Min.",
                totalTime: "3:00 Std.",
                approachTime: "1:30 Std.",
                descentTime: "1:00 Std.",
                character: "Origineller und lohnender Einsteigersteig mit perfektem Ausblick auf Watzmann, Berchtesgaden und den Königssee; auch familiengeeignet.",
                topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/tour/topo/22892/laxersteig-schuetzensteig-klettersteig-jenner-topo.png")!,
                coordinates: CLLocationCoordinate2D(latitude: 47.580331866500295, longitude: 13.024610835980944),
                location: "Schönau am Königssee",
                infoLink: URL(string: "https://www.bergfex.at/sommer/bayern/touren/wanderung/3790237,koenigsee-klettersteige/")
            ),
            ClimbingRoute(
                name: "Laxersteig Klettersteig – Jenner",
                difficulty: "C/D",
                climbingHeight: "70 Hm",
                totalHeight: "570 Hm",
                climbingTime: "0:30 Min.",
                totalTime: "3:00 Std.",
                approachTime: "1:30 Std.",
                descentTime: "1:00 Std.",
                character: "Längere Ferrata-Kombination am Jenner, die tiefer beginnt als der Schützensteig und durch steile, glatte Felspassagen führt – anspruchsvoll an bestimmten Stellen.",
                topoImageURL: URL(string: "https://www.bergsteigen.com/fileadmin/userdaten/tour/topo/22892/laxersteig-schuetzensteig-klettersteig-jenner-topo.png")!,
                coordinates: CLLocationCoordinate2D(latitude: 47.58034634089606, longitude: 13.024213869083074),
                location: "Schönau am Königssee",
                infoLink: URL(string: "https://www.bergfex.at/sommer/bayern/touren/wanderung/3790237,koenigsee-klettersteige/")
            )
        ]
    }
    
    // Funktion, um Klettersteige nach Standort zu gruppieren
    func routesByLocation() -> [String: [ClimbingRoute]] {
        Dictionary(grouping: climbingRoutes) { $0.location }
    }
    
    // Benutzerdefinierte Sortierreihenfolge für Orte
    func locationSortOrder(_ location: String) -> Int {
        let orderList = [
            "St. Johann in Tirol",
            "Ellmau",
            "St. Ulrich am Pillersee",
            "Weißbach bei Lofer",
            "Schönau am Königssee"
        ]
        
        if let index = orderList.firstIndex(of: location) {
            return index
        }
        // Nicht definierte Orte ans Ende setzen
        return 999
    }
}
