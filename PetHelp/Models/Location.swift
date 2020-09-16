//
//  Location.swift
//  PetHelp
//
//  Created by Lucas Silveira on 30/08/20.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
    let placemark: MKPlacemark
}

extension Array {
    mutating func appendLocation(location: Location) {
        self.append(location as! Element)
    }
}
