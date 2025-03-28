import SwiftUI

class ViennaActivityViewModel: ObservableObject {
    @Published var activities: [ViennaActivity] = []
    
    init() {
        loadActivities()
    }
    
    private func loadActivities() {
        // Aktivitäten & Ausflüge
        activities.append(contentsOf: [
            ViennaActivity(
                name: "Wiener Stadtwege",
                description: "Wenn Sie die Natur lieben, hat Wien viel zu bieten: Entdecken Sie 13 Wanderwege mit einmaligen Ausblicken auf die Stadt und ihre Umgebung. Für jeden Wanderweg ist ein ganzer Tag einzuplanen.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/wien-wanderweg-1.jpg"),
                category: .activitiesExcursions
            ),
            ViennaActivity(
                name: "Haus des Meeres",
                description: "Das Haus des Meeres in Wien ist ein beeindruckender Aqua Terra Zoo, der sich über 11 Stockwerke erstreckt. Hier können Besucher verschiedenste Tierarten aus nächster Nähe kennenlernen und in Echtzeit beobachten.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Haus-des-Meeres.jpg"),
                category: .activitiesExcursions
            ),
            ViennaActivity(
                name: "Wiener Prater",
                description: "Der Wiener Prater ist ein weitläufiger Vergnügungspark in Wien, der für seine nostalgischen Fahrgeschäfte, das berühmte Riesenrad und die grünen Alleen bekannt ist.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel.png"),
                category: .activitiesExcursions
            ),
            ViennaActivity(
                name: "Donauinsel",
                description: "Auf der Donauinsel gibt es zahlreiche Möglichkeiten, aktiv zu werden. Ob Boot fahren, schwimmen oder joggen – die Insel bietet ideale Bedingungen für verschiedenste Freizeitaktivitäten.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-1.png"),
                category: .activitiesExcursions
            ),
            ViennaActivity(
                name: "Donauturm",
                description: "Für alle, die Wien erkunden möchten und Abenteuerlust mitbringen: Der Donauturm ist genau das Richtige. Mit dem Expresslift geht es in 150 Meter Höhe, wo Sie ein spektakuläres 360°-Panorama genießen können.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-1-1.png"),
                category: .activitiesExcursions
            )
        ])
        
        // Kunst & Kultur
        activities.append(contentsOf: [
            ViennaActivity(
                name: "Schloss Schönbrunn",
                description: "In den original eingerichteten kaiserlichen Prunk- und Wohnräumen erhalten Sie einen Einblick in das Leben von Maria Theresia, Kaiser Franz Joseph und Kaiserin Elisabeth, die auch als Sisi bekannt ist.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-2.png"),
                category: .artCulture
            ),
            ViennaActivity(
                name: "Das Belvedere",
                description: "Das Schloss Belvedere in Wien, erbaut von Johann Lucas von Hildebrandt, ist eine beeindruckende Schlossanlage. Heute sind in den beiden Schlossgebäuden die Sammlungen des Belvedere untergebracht, darunter die österreichische Galerie Belvedere.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-7.png"),
                category: .artCulture
            ),
            ViennaActivity(
                name: "Das Hundertwasserhaus",
                description: "Das Hundertwasserhaus in Wien ist eine außergewöhnliche Wohnanlage, die zwischen 1983 und 1985 errichtet wurde. Direkt gegenüber befindet sich das Hundertwasserhaus Village, das besichtigt werden kann.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-3.png"),
                category: .artCulture
            ),
            ViennaActivity(
                name: "Das Weltmuseum",
                description: "Das Weltmuseum Wien ist bekannt für seine umfangreiche Sammlung ethnografischer Artefakte aus allen Regionen der Erde. Hier erwartet Sie eine Vielfalt an Kulturobjekten, die Ihnen spannende Einblicke in die unterschiedlichsten Kulturen und Traditionen bieten.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-8.png"),
                category: .artCulture
            ),
            ViennaActivity(
                name: "Wiener Staatsoper",
                description: "Die Wiener Staatsoper befindet sich im Herzen Wiens und bietet ein vielseitiges Repertoire, das von klassischen Opern bis hin zu modernen Inszenierungen reicht. Sie ist bekannt für ihre beeindruckende Architektur und ihre reiche Geschichte.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-13.png"),
                category: .artCulture
            ),
            ViennaActivity(
                name: "Karlskirche",
                description: "Die Karlskirche in Wien, ein prächtiges barockes Bauwerk, wurde im 18. Jahrhundert zu Ehren des heiligen Karl Borromäus errichtet. Besonders bekannt ist sie für ihre imposante Kuppel und die beiden flankierenden Säulen, die mit Reliefs aus dem Leben des Heiligen geschmückt sind.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-1-3.png"),
                category: .artCulture
            ),
            ViennaActivity(
                name: "Albertina",
                description: "Die Albertina in Wien beherbergt eine der bedeutendsten grafischen Sammlungen der Welt, mit Werken von Künstlern wie Dürer, Klimt und Picasso. Das Museum, das in einem prächtigen historischen Palais untergebracht ist, bietet zudem wechselnde Ausstellungen moderner und zeitgenössischer Kunst.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-2-2.png"),
                category: .artCulture
            ),
            ViennaActivity(
                name: "Hofburg",
                description: "Die Hofburg in Wien, einst die Residenz der Habsburger, ist ein prächtiger Palastkomplex, der heute mehrere Museen und die Österreichische Nationalbibliothek beherbergt. Sie ist ein historisches Zentrum der Macht und Kultur, in dem auch der Wiener Opernball stattfindet.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-3-2.png"),
                category: .artCulture
            ),
            ViennaActivity(
                name: "Das Kunsthistorische Museum",
                description: "Das Kunsthistorische Museum in Wien ist eines der bedeutendsten Kunstmuseen der Welt und beherbergt eine beeindruckende Sammlung von Meisterwerken, darunter Werke von Künstlern wie Bruegel, Vermeer und Raphael.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-4-2.png"),
                category: .artCulture
            )
        ])
        
        // Bars & Cafés
        activities.append(contentsOf: [
            ViennaActivity(
                name: "Das Loft",
                description: "Im 18. Stock des SO/Vienna befindet sich das LOFT, die kulinarische Krönung. Von hier aus können Sie nicht nur köstliche Spezialitäten im Restaurant genießen, sondern auch einen atemberaubenden Blick über Wien werfen.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-9.png"),
                category: .barsCafes
            ),
            ViennaActivity(
                name: "Motto am Fluss",
                description: "Das Motto am Fluss ist ein beliebtes Restaurant in Wien, das sich am Schwedenplatz befindet. Es erstreckt sich über zwei Ebenen und bietet einzigartige Ausblicke sowie kulinarische Köstlichkeiten.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-10.png"),
                category: .barsCafes
            ),
            ViennaActivity(
                name: "Café Gloriette",
                description: "Das Café Gloriette liegt auf einer Anhöhe im Schlosspark Schönbrunn und bietet einen grandiosen Blick auf Wien. In dem prächtigen Bauwerk ist heute das Café Gloriette untergebracht.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-11.png"),
                category: .barsCafes
            ),
            ViennaActivity(
                name: "Plus43",
                description: "Die Plus43 ist eine sehr bemerkenswerte Bar in Wien. Sie ist für ihre Vielzahl an erstklassigen Drinks bekannt. Die Bar wird oft mit geheimen Tür Code Plus43 verglichen.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-12.png"),
                category: .barsCafes
            ),
            ViennaActivity(
                name: "Fitzcarraldo",
                description: "Die Fitzcarraldo Bar ist eine geheime Speakeasy-Bar in Wien. Die Bar ist bekannt für ihre schillernde, fantasievolle Welt, zu der man über einen Getränkeautomaten Zugang erhält.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-1-2.png"),
                category: .barsCafes
            )
        ])
        
        // Kulinarik
        activities.append(contentsOf: [
            ViennaActivity(
                name: "Ebi 7",
                description: "Das Ebi 7 bietet eine Vielzahl von Leckereien an, angefangen von Sushi bis hin zu leckeren Tepanyaki Gerichten. Das Konzept des Restaurants ist einzigartig in Österreich. Bestellt wird über ein Tablet in „All you can eat",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-2-1.png"),
                category: .culinary
            ),
            ViennaActivity(
                name: "Rollercoaster Restaurant",
                description: "Das Rollercoaster Restaurant ist ein einzigartiges Gastronomieerlebnis, bei dem Speisen und Getränke über ein ausgeklügeltes Schienensystem direkt an den Tisch geliefert werden. Das Restaurant befindet sich am Wiener Prater.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-3-1.png"),
                category: .culinary
            ),
            ViennaActivity(
                name: "Dinner in the Sky",
                description: "Das Dinner in the Sky ist ein außergewöhnliches kulinarisches Erlebnis, bei dem ein gedeckter Tisch samt Gästen mittels eines Krans in luftige Höhen gehoben wird. Dieses Event findet weltweit an verschiedenen Orten statt.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-25.png"),
                category: .culinary
            ),
            ViennaActivity(
                name: "Glacis Beisl",
                description: "Das Glacis Beisl ist ein charmantes Restaurant im MuseumsQuartier Wien, das traditionelle Wiener Küche in modernem Ambiente serviert. Mit seinem idyllischen Gastgarten bietet es eine ruhige Oase im Herzen der Stadt, ideal für entspannte Stunden bei gutem Essen.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-31.png"),
                category: .culinary
            ),
            ViennaActivity(
                name: "Seven Paintings",
                description: "Das Seven Paintings ist ein hochkarätiges Restaurant in Wien, das Kunst und Kulinarik auf elegante Weise miteinander verbindet. Jedes Gericht wird von einem der sieben berühmten Gemälde inspiriert, die das Interieur des Restaurants schmücken.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-7-1.png"),
                category: .culinary
            )
        ])
        
        // Entdecken & Auszeit
        activities.append(contentsOf: [
            ViennaActivity(
                name: "Stephansdom",
                description: "Der Stephansdom ist Wiens bedeutendstes gotisches Bauwerk und ein Wahrzeichen der Stadt. Erkunden Sie die beeindruckende Architektur, steigen Sie die 343 Stufen des Südturms hinauf für einen atemberaubenden Blick über Wien.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-15.png"),
                category: .discoverRelax
            ),
            ViennaActivity(
                name: "Stadtpark",
                description: "Der Wiener Stadtpark ist eine grüne Oase im Herzen der Stadt. Ideal für einen entspannten Spaziergang, Picknick oder einfach zum Entspannen auf den Wiesen. Berühmt ist das Johann-Strauss-Denkmal, ein beliebtes Fotomotiv.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-14.png"),
                category: .discoverRelax
            ),
            ViennaActivity(
                name: "Museums Quartier",
                description: "Das Museums Quartier bietet eine beeindruckende Sammlung von Museen, Kunstinstallationen und kulturellen Veranstaltungen. Genießen Sie die entspannte Atmosphäre in den Höfen, besichtigen Sie moderne und zeitgenössische Kunst oder nehmen Sie an einem der vielen Events teil.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-16-1.png"),
                category: .discoverRelax
            ),
            ViennaActivity(
                name: "Naschmarkt",
                description: "Der Naschmarkt ist Wiens berühmtester Markt, der eine Vielzahl von frischen Lebensmitteln, exotischen Gewürzen und internationalen Gerichten bietet. Schlendern Sie durch die bunten Stände, probieren Sie lokale Spezialitäten und genießen Sie die lebendige Marktatmosphäre.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-17.png"),
                category: .discoverRelax
            ),
            ViennaActivity(
                name: "Kahlenberg",
                description: "Der Kahlenberg bietet einen herrlichen Panoramablick über Wien und die umliegenden Weinberge. Ideal für Wanderungen, Radtouren oder einfach zum Entspannen. Genießen Sie den Ausblick von der Aussichtsplattform und kehren Sie in einem der gemütlichen Heurigen ein.",
                imageURL: URL(string: "https://www.slg.co.at/wp-content/uploads/2024/07/Design-ohne-Titel-30.png"),
                category: .discoverRelax
            )
        ])
        
        // Shopping und Nachtleben wurden entfernt
    }
    
    // Hilfsfunktion zum Gruppieren der Aktivitäten nach Kategorie
    func activitiesByCategory() -> [ViennaActivityCategory: [ViennaActivity]] {
        Dictionary(grouping: activities) { $0.category }
    }
}
