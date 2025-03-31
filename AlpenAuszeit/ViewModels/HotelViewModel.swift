import SwiftUI
import MapKit

class HotelViewModel: ObservableObject {
    @Published var hotels: [Hotel] = []
    @Published var currentHotel: Hotel?
    @Published var simulatedDate: Date? // Neues Property für simuliertes Datum
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        formatter.locale = Locale(identifier: "de_DE")
        return formatter
    }()
    
    func formattedDate(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    init() {
        setupHotels()
        updateCurrentHotel()
    }
    
    func setupHotels() {
        hotels = [
            Hotel(
                name: "Flemings Selection Hotel Wien-City",
                location: "Wien",
                checkIn: dateFormatter.date(from: "26.04.25")!,
                checkOut: dateFormatter.date(from: "28.04.25")!,
                checkInTime: "15:00",
                checkOutTime: "14:00",
                boardType: "Frühstück",
                mapLink: URL(string: "https://maps.app.goo.gl/2EMHkLRy7928jGqHA")!,
                images: [
                    "https://image-tc.galaxy.tf/wijpeg-cl183m9gooklg3six4a8ohgyo/flemings-selection-hotel-wien-city-exterio-2.jpg",
                    "https://image-tc.galaxy.tf/wijpeg-35wt83nx990ozz6z7w2qxpia3/flemings-selection-hotel-wien-city-fruhstuck.jpg",
                    "https://image-tc.galaxy.tf/wijpeg-2tipm10ifmmqvx3t5nu92f1nw/flemings-selection-hotel-wien-city-zimmer-superior-plus-city-view-01.jpg",
                    "https://image-tc.galaxy.tf/wijpeg-dbv01cu0f5a8dmd4xnwp7svdd/flemings-selection-hotel-wien-city-zimmer-superior-king-master-01.jpg",
                    "https://image-tc.galaxy.tf/wijpeg-7lsmieae2bgxee8qjfb2skk4l/flemings-selection-hotel-wien-city-wellness.jpg"
                ],
                coordinates: CLLocationCoordinate2D(latitude: 48.2083, longitude: 16.3583)
            ),
            Hotel(
                name: "Alpenhotel Kaiserfels",
                location: "St. Johann in Tirol",
                checkIn: dateFormatter.date(from: "28.04.25")!,
                checkOut: dateFormatter.date(from: "05.05.25")!,
                checkInTime: "15:00",
                checkOutTime: "11:00",
                boardType: "Halbpension",
                mapLink: URL(string: "https://maps.app.goo.gl/dPGPqFvoynLcnUEy8")!,
                images: [
                    "https://www.kaiserfels.com/userdata/6068/gallery/9300/thumbnails/img_e5838_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9300/thumbnails/img_e6340_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9300/thumbnails/img_5024_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9301/thumbnails/1_dsc_0930_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9301/thumbnails/dsc_0904_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9301/thumbnails/doppelzimmer_executive_lti_kaiserfels0891_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9302/thumbnails/dsc00016_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9302/thumbnails/img_6823_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9302/thumbnails/krutersauna_2_2000x1329.jpeg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9302/thumbnails/saunen_2000x1329.jpeg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9304/thumbnails/img_6125_2000x1329.jpg",
                    "https://www.kaiserfels.com/userdata/6068/gallery/9304/thumbnails/dscf8945_2000x1329.jpg"
                ],
                coordinates: CLLocationCoordinate2D(latitude: 47.5226, longitude: 12.4256)
            ),
            Hotel(
                name: "Amber Hotel Bavaria",
                location: "Bad Reichenhall",
                checkIn: dateFormatter.date(from: "05.05.25")!,
                checkOut: dateFormatter.date(from: "10.05.25")!,
                checkInTime: "16:00",
                checkOutTime: "11:00",
                boardType: "Frühstück",
                mapLink: URL(string: "https://maps.app.goo.gl/hrgPMwv4TamHQgt6A")!,
                images: [
                    "https://www.amber-hotels.de/wp-content/uploads/sites/2/2024/05/aussen-24-1-1920x1080.jpeg",
                    "https://www.amber-hotels.de/wp-content/uploads/sites/2/2024/05/Lobby-final--1920x1080.jpeg",
                    "https://www.amber-hotels.de/wp-content/uploads/sites/2/2015/08/amber-residenz-bavaria-comfort-zimmer.jpg",
                    "https://www.amber-hotels.de/wp-content/uploads/sites/2/2015/08/amber-residenz-bavaria-landhauszimmer.jpg",
                    "https://www.amber-hotels.de/wp-content/uploads/sites/2/2022/02/amber-hotel-bavaria-pool_source_83435-1920x1080.jpg",
                    "https://www.amber-hotels.de/wp-content/uploads/sites/2/2022/08/gradierwerk-2-1920x1080.jpg",
                    "https://cdn.amber-hotels.de/wp-content/uploads/sites/2/2024/05/sauna1-scaled.jpeg"
                ],
                coordinates: CLLocationCoordinate2D(latitude: 47.7275, longitude: 12.8777)
            )
        ]
    }
    
    // Aktualisierte Methode, die entweder das simulierte oder das aktuelle Datum verwendet
    func updateCurrentHotel() {
        // Verwende simuliertes Datum, wenn vorhanden, sonst aktuelles Datum
        let today = simulatedDate ?? Date()
        
        print("HotelViewModel: Aktualisiere aktuelles Hotel für Datum: \(formattedDate(from: today))")
        
        currentHotel = hotels.first(where: {
            today >= $0.checkIn && today <= $0.checkOut
        }) ?? hotels.first
        
        if let selectedHotel = currentHotel {
            print("HotelViewModel: Ausgewähltes Hotel: \(selectedHotel.name) in \(selectedHotel.location)")
        } else {
            print("HotelViewModel: Kein passendes Hotel gefunden, verwende erstes Hotel")
        }
    }
    
    // Neue Methode, um ein bestimmtes Datum zu simulieren
    func simulateDate(_ date: Date) {
        print("HotelViewModel: Simuliere Datum: \(formattedDate(from: date))")
        simulatedDate = date
        updateCurrentHotel()
    }
    
    // Neue Methode, um die Simulation zurückzusetzen
    func resetSimulation() {
        print("HotelViewModel: Setze Simulation zurück auf aktuelles Datum")
        simulatedDate = nil
        updateCurrentHotel()
    }
    
    func formattedDateRange(for hotel: Hotel) -> String {
        return "\(dateFormatter.string(from: hotel.checkIn)) - \(dateFormatter.string(from: hotel.checkOut))"
    }
}
