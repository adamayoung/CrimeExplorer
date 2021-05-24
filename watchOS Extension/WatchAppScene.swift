import SwiftUI

struct WatchAppScene: Scene {

    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
        }

        WKNotificationScene(controller: NotificationController.self, category: "Notification")
    }

}
