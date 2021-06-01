import Foundation
import MapKit

extension MKCoordinateRegion {

    private static var visibleAnnotationsDelta: Double {
        0.04
    }

    private static var visibleAnnotationLabelsDelta: Double {
        0.01
    }

    var shouldAnnotationsBeVisible: Bool {
        span.latitudeDelta < Self.visibleAnnotationsDelta
            && span.longitudeDelta < Self.visibleAnnotationsDelta
    }

    var shouldAnnotationLabelsBeVisible: Bool {
        span.latitudeDelta < Self.visibleAnnotationLabelsDelta
            && span.longitudeDelta < Self.visibleAnnotationLabelsDelta
    }

}
