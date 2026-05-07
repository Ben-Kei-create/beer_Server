import GoogleMobileAds
import SwiftUI

@main
struct BeerQuizApp: App {
    init() {
        MobileAds.shared.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
