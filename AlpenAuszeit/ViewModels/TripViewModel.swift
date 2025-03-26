import SwiftUI

class TripViewModel: ObservableObject {
    @Published var trips: [Trip] = []
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        formatter.locale = Locale(identifier: "de_DE")
        return formatter
    }()
    
    init() {
        setupTrips()
    }
    
    func setupTrips() {
        trips = [
            Trip(
                date: dateFormatter.date(from: "26.04.25")!,
                departureTime: "04:30",
                arrivalTime: "12:47",
                from: "Berlin Hbf",
                to: "Wien Hbf",
                stations: [
                    TripStation(time: "04:30", location: "Berlin Hbf", platform: "Gleis 4", isTransfer: false),
                    TripStation(time: "08:08", location: "Nürnberg Hbf", platform: "Gleis 9", isTransfer: true),
                    TripStation(time: "08:31", location: "Nürnberg Hbf", platform: "Gleis 8", isTransfer: true),
                    TripStation(time: "12:47", location: "Wien Hbf", platform: "Gleis 5A-B", isTransfer: false)
                ]
            ),
            Trip(
                date: dateFormatter.date(from: "28.04.25")!,
                departureTime: "09:55",
                arrivalTime: "15:25",
                from: "Wien Hbf",
                to: "St. Johann in Tirol",
                stations: [
                    TripStation(time: "09:55", location: "Wien Hbf", platform: "Gleis 8A-B", isTransfer: false),
                    TripStation(time: "12:49", location: "Salzburg Hbf", platform: "Gleis 2", isTransfer: true),
                    TripStation(time: "12:56", location: "Salzburg Hbf", platform: "Gleis 3D-F", isTransfer: true),
                    TripStation(time: "14:13", location: "Wörgl Hbf", platform: "Gleis 4", isTransfer: true),
                    TripStation(time: "15:12", location: "St. Johann in Tirol Grieswirt Bahnhst", platform: "Gleis 1", isTransfer: true),
                    TripStation(time: "15:23", location: "St. Johann in Tirol Grieswirt (B164)", platform: "Bus 8301", isTransfer: true),
                    TripStation(time: "15:25", location: "St. Johann in Tirol Eichenhof", platform: "", isTransfer: false)
                ]
            ),
            Trip(
                date: dateFormatter.date(from: "05.05.25")!,
                departureTime: "10:30",
                arrivalTime: "12:14",
                from: "St. Johann in Tirol",
                to: "Bad Reichenhall",
                stations: [
                    TripStation(time: "10:30", location: "St. Johann in Tirol Bahnhof (Bahnhofstraße)", platform: "Bus 4012", isTransfer: false),
                    TripStation(time: "11:05", location: "Lofer Mittelschule/Tourismusverband", platform: "", isTransfer: true),
                    TripStation(time: "11:43", location: "Lofer Mittelschule/Tourismusverband", platform: "Bus 260", isTransfer: true),
                    TripStation(time: "12:14", location: "Bad Reichenhall Hbf (Busbahnhof)", platform: "", isTransfer: false)
                ]
            ),
            Trip(
                date: dateFormatter.date(from: "10.05.25")!,
                departureTime: "16:00",
                arrivalTime: "23:32",
                from: "Bad Reichenhall",
                to: "Berlin Hbf",
                stations: [
                    TripStation(time: "16:00", location: "Bad Reichenhall", platform: "Gleis 3", isTransfer: false),
                    TripStation(time: "16:18", location: "Freilassing", platform: "Gleis 3", isTransfer: true),
                    TripStation(time: "16:24", location: "Freilassing", platform: "Gleis 4", isTransfer: true),
                    TripStation(time: "18:06", location: "München Hbf", platform: "Gleis 4", isTransfer: true),
                    TripStation(time: "18:55", location: "München Hbf", platform: "Gleis 22", isTransfer: true),
                    TripStation(time: "23:32", location: "Berlin Hbf", platform: "Gleis 7", isTransfer: false)
                ]
            )
        ]
    }
    
    func formattedDate(for trip: Trip) -> String {
        return dateFormatter.string(from: trip.date)
    }
}
