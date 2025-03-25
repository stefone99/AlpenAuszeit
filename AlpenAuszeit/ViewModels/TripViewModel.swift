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
                to: "Wien Hbf"
            ),
            Trip(
                date: dateFormatter.date(from: "28.04.25")!,
                departureTime: "09:55",
                arrivalTime: "15:25",
                from: "Wien Hbf",
                to: "St. Johann in Tirol"
            ),
            Trip(
                date: dateFormatter.date(from: "05.05.25")!,
                departureTime: "10:31",
                arrivalTime: "12:14",
                from: "St. Johann in Tirol",
                to: "Bad Reichenhall"
            ),
            Trip(
                date: dateFormatter.date(from: "10.05.25")!,
                departureTime: "09:30",
                arrivalTime: "18:45",
                from: "Bad Reichenhall",
                to: "Berlin Hbf"
            )
        ]
    }
    
    func formattedDate(for trip: Trip) -> String {
        return dateFormatter.string(from: trip.date)
    }
}
