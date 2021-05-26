import SwiftUI

struct ContentView: View {

    @StateObject private var model = AppModel()

    var body: some View {
        CrimeMapView()
            .ignoresSafeArea()
            .environmentObject(model)
    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }

}
