import SwiftUI

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
                character: "Kurzer, steiler Steig durch die breite Felswand des Niederkaisers; ideal als Einstiegstour."
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
                character: "Kurzweiliges Übungserlebnis an einem kleinen Felsblock; kombinierbar mit Aufstieg zum Baumgartenkopf."
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
                character: "Kurzer Steig oberhalb des Kirchleins St. Adolari, der an einem Klettergarten vorbeiführt; auch bei unsicherem Wetter interessant."
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
                character: "Lohnender Anfängerstieg in Weißbach bei Lofer, verläuft im AV-Klettergarten – familienfreundlich."
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
                character: "Klassischer Einsteigersteig in Weißbach bei Lofer, ideal um erste Erfahrungen mit Stahlseilen zu sammeln."
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
                character: "Anspruchsvoller Steig über dem Königssee mit mehreren Varianten, spektakulären Aussichten und technisch fordernden Passagen."
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
                character: "Origineller und lohnender Einsteigersteig mit perfektem Ausblick auf Watzmann, Berchtesgaden und den Königssee; auch familiengeeignet."
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
                character: "Längere Ferrata-Kombination am Jenner, die tiefer beginnt als der Schützensteig und durch steile, glatte Felspassagen führt – anspruchsvoll an bestimmten Stellen."
            )
        ]
    }
}
