//
//  CLLocationCoordinate2D+Equatable.swift
//  CrimeExplorer
//
//  Created by Adam Young on 26/05/2021.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {

    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

}
