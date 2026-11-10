import SwiftUI

@main
struct RuqyahApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(nil) // respect system setting
        }
    }
}
