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
}

extension Location {
    static func getLocation() -> [Location] {
        return [
            Location(title: "Iguatemi Rio Preto", coordinate: CLLocationCoordinate2D(latitude: -20.8664543, longitude: -49.4144121)),
            Location(title: "Box 5 (Verme)", coordinate: CLLocationCoordinate2D(latitude: -20.80963, longitude: -49.3962918))
        ]
    }
}
