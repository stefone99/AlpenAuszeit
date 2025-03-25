import SwiftUI

class HikingViewModel: ObservableObject {
    @Published var hikes: [Hike] = []
    
    init() {
        setupHikes()
    }
    
    func setupHikes() {
        hikes = [
            Hike(
                name: "Teufelsgasse",
                region: "Tirol",
                infoLink: URL(string: "https://www.bergfex.at/sommer/tirol/touren/wanderung/3650754,teufelsgasse/")!,
                difficulty: "Mittel",
                duration: "2-3 Stunden",
                description: "Eine beeindruckende Wanderung durch die Teufelsgasse, eine schmale Felsschlucht mit atemberaubenden Ausblicken und interessanten Felsformationen."
            ),
            Hike(
                name: "Grießbachklamm",
                region: "Tirol",
                infoLink: URL(string: "https://www.bergfex.at/sommer/tirol/touren/wanderung/3650758,griessbachklamm/")!,
                difficulty: "Leicht-Mittel",
                duration: "2 Stunden",
                description: "Ein Naturjuwel in den Kitzbüheler Alpen. Die Grießbachklamm besticht durch ihre wilde Schönheit und die rauschenden Wasserfälle."
            )
        ]
    }
}
