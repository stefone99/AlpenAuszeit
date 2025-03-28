import SwiftUI

// UIKitTabBarController als UIViewControllerRepresentable für mehr Kontrolle
struct UIKitTabViewController: UIViewControllerRepresentable {
    var viewControllers: [UIViewController]
    var tabBarItems: [(title: String, image: UIImage)]
    var tintColor: UIColor
    
    func makeUIViewController(context: Context) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.tintColor = tintColor
        
        // Tab-Bar-Items manuell konfigurieren
        for i in 0..<min(viewControllers.count, tabBarItems.count) {
            viewControllers[i].tabBarItem = UITabBarItem(
                title: tabBarItems[i].title,
                image: tabBarItems[i].image,
                tag: i
            )
        }
        
        // Auf iPadOS spezifisch Einstellungen erzwingen
        if UIDevice.current.userInterfaceIdiom == .pad {
            tabBarController.tabBar.isTranslucent = true
            
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                appearance.configureWithDefaultBackground()
                
                // Forciere Icons und Text wie beim iPhone
                appearance.stackedLayoutAppearance.normal.iconColor = .gray
                appearance.stackedLayoutAppearance.selected.iconColor = tintColor
                
                tabBarController.tabBar.standardAppearance = appearance
                tabBarController.tabBar.scrollEdgeAppearance = appearance
            }
        }
        
        return tabBarController
    }
    
    func updateUIViewController(_ uiViewController: UITabBarController, context: Context) {
        // Hier könnten wir auf Änderungen reagieren
    }
}

struct ContentView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var hotelViewModel = HotelViewModel()
    @StateObject private var tripViewModel = TripViewModel()
    @StateObject private var hikingViewModel = HikingViewModel()
    @StateObject private var climbingViewModel = ClimbingViewModel()
    
    // Wetter-ViewModel mit dem LocationManager initialisieren
    @StateObject private var weatherViewModel: WeatherViewModel
    
    // Initialisierer für die ViewModel-Erstellung mit dem LocationManager
    init() {
        // Da wir @EnvironmentObject erst in der View haben, müssen wir einen
        // temporären LocationManager für die Initialisierung erstellen
        let tempLocationManager = LocationManager()
        _weatherViewModel = StateObject(wrappedValue: WeatherViewModel(locationManager: tempLocationManager))
        
        // Entferne den grauen Hintergrund der TabBar im iOS 15+
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    
    var body: some View {
        // Check ob wir auf iPad sind und dann erzwingen wir ein TabBar-Layout
        if UIDevice.current.userInterfaceIdiom == .pad {
            iPadTabBarView
                .onAppear {
                    setupLocationManager()
                }
        } else {
            // Standard SwiftUI TabView für iPhone
            standardTabView
                .onAppear {
                    setupLocationManager()
                }
        }
    }
    
    // Funktion zur Einrichtung des LocationManager
    private func setupLocationManager() {
        // LocationManager aktualisieren
        weatherViewModel.locationManager = locationManager
        
        // Standortaktualisierung anfordern
        if locationManager.authorizationStatus == .authorizedWhenInUse ||
           locationManager.authorizationStatus == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    
    // Standard SwiftUI TabView für iPhone
    private var standardTabView: some View {
        TabView {
            NavigationView {
                CurrentView(
                    hotelViewModel: hotelViewModel,
                    weatherViewModel: weatherViewModel
                )
            }
            .tabItem {
                Image(systemName: "house")
                Text("Aktuell")
            }
            
            NavigationView {
                HotelListView(viewModel: hotelViewModel)
                    .navigationTitle("Hotels")
            }
            .tabItem {
                Image(systemName: "building")
                Text("Hotels")
            }
            
            NavigationView {
                TripListView(viewModel: tripViewModel)
                    .navigationTitle("Fahrten")
            }
            .tabItem {
                Image(systemName: "tram")
                Text("Fahrten")
            }
            
            NavigationView {
                HikingListView(viewModel: hikingViewModel)
                    .navigationTitle("Wanderungen")
            }
            .tabItem {
                Image(systemName: "mountain.2")
                Text("Wanderungen")
            }
            
            NavigationView {
                ClimbingListView(viewModel: climbingViewModel)
                    .navigationTitle("Klettersteige")
            }
            .tabItem {
                Image(systemName: "figure.climbing")
                Text("Klettersteige")
            }
        }
        .accentColor(.blue)
    }
    
    // iPad-spezifische TabView mit UIKit
    private var iPadTabBarView: some View {
        UIKitTabViewController(
            viewControllers: [
                UIHostingController(rootView: NavigationSplitView {
                    CurrentView(hotelViewModel: hotelViewModel, weatherViewModel: weatherViewModel)
                        .navigationTitle("Aktuell")
                } detail: {
                    Text("Wählen Sie einen Eintrag für Details")
                }),
                
                UIHostingController(rootView: NavigationSplitView {
                    HotelListView(viewModel: hotelViewModel)
                        .navigationTitle("Hotels")
                } detail: {
                    Text("Wählen Sie ein Hotel für Details")
                }),
                
                UIHostingController(rootView: NavigationSplitView {
                    TripListView(viewModel: tripViewModel)
                        .navigationTitle("Fahrten")
                } detail: {
                    Text("Wählen Sie eine Fahrt für Details")
                }),
                
                UIHostingController(rootView: NavigationSplitView {
                    HikingListView(viewModel: hikingViewModel)
                        .navigationTitle("Wanderungen")
                } detail: {
                    Text("Wählen Sie eine Wanderung für Details")
                }),
                
                UIHostingController(rootView: NavigationSplitView {
                    ClimbingListView(viewModel: climbingViewModel)
                        .navigationTitle("Klettersteige")
                } detail: {
                    Text("Wählen Sie einen Klettersteig für Details")
                })
            ],
            tabBarItems: [
                ("Aktuell", UIImage(systemName: "info.circle")!),
                ("Hotel", UIImage(systemName: "building")!),
                ("Fahrten", UIImage(systemName: "tram")!),
                ("Wanderungen", UIImage(systemName: "mountain.2")!),
                ("Klettersteige", UIImage(systemName: "figure.climbing")!)
            ],
            tintColor: UIColor.systemBlue
        )
        .ignoresSafeArea(.all) // Volle Bildschirmnutzung
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 15 Pro")
                .environmentObject(LocationManager())
            
            ContentView()
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
                .environmentObject(LocationManager())
        }
    }
}
