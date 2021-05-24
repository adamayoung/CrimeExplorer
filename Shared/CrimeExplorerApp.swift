import SwiftUI

@main
struct CrimeExplorerApp: App {

    @SceneBuilder var body: some Scene {
        #if os(iOS)
        IOSAppScene()
        #elseif os(watchOS)
        WatchAppScene()
        #else
        MacAppScene()
        #endif
    }

}
