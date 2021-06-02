import SwiftUI

struct ContentView: View {

    @StateObject private var model = AppModel()

    var body: some View {
        CrimeMapView()
            .environmentObject(model)
    }

}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro")
    }

}
