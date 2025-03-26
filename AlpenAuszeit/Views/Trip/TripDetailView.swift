import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    @ObservedObject var viewModel: TripViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Überschriften und Hauptinformationen
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(trip.from) → \(trip.to)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(viewModel.formattedDate(for: trip))
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Label(trip.departureTime, systemImage: "clock")
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Label(trip.arrivalTime, systemImage: "clock.fill")
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 5)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(radius: 2)
                )
                .padding(.horizontal)
                
                Divider()
                    .padding(.vertical, 5)
                
                // Stationenliste
                Text("Fahrtverlauf")
                    .font(.headline)
                    .padding(.horizontal)
                
                // Verlauf mit Timeline
                VStack(spacing: 0) {
                    ForEach(trip.stations.indices, id: \.self) { index in
                        let station = trip.stations[index]
                        let isFirst = index == 0
                        let isLast = index == trip.stations.count - 1
                        
                        HStack(alignment: .top, spacing: 15) {
                            // Zeitlinie
                            VStack(spacing: 0) {
                                // Oberer Punkt/Linie
                                if isFirst {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 14, height: 14)
                                        .padding(.top, 3)
                                } else {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.5))
                                        .frame(width: 2)
                                        .frame(height: 15)
                                    
                                    if station.isTransfer {
                                        Circle()
                                            .stroke(Color.orange, lineWidth: 2)
                                            .frame(width: 14, height: 14)
                                    } else {
                                        Circle()
                                            .fill(isLast ? Color.blue : Color.gray.opacity(0.7))
                                            .frame(width: 10, height: 10)
                                    }
                                }
                                
                                // Untere Linie
                                if !isLast {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.5))
                                        .frame(width: 2)
                                        .frame(height: station.isTransfer ? 40 : 30)
                                }
                            }
                            
                            // Station Information
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(station.time)
                                        .font(.headline)
                                        .foregroundColor(isFirst || isLast ? .blue : .primary)
                                        .frame(width: 60, alignment: .leading)
                                    
                                    if station.isTransfer {
                                        Text("Umstieg")
                                            .font(.caption)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 2)
                                            .background(Color.orange.opacity(0.2))
                                            .foregroundColor(.orange)
                                            .clipShape(Capsule())
                                    }
                                }
                                
                                Text(station.location)
                                    .font(.body)
                                
                                if !station.platform.isEmpty {
                                    Text(station.platform)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                
                                if station.isTransfer {
                                    Spacer()
                                        .frame(height: 8)
                                }
                            }
                            .padding(.bottom, station.isTransfer ? 15 : 10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Fahrtverlauf")
        .navigationBarTitleDisplayMode(.inline)
    }
}
