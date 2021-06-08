import SwiftUI

struct WatchAppScene: Scene {

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "Notification")
    }

}
