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
            Location(title: "shop", coordinate: CLLocationCoordinate2D(latitude: -20.8355829, longitude: -49.4005878))
        ]
    }

    static func makeLocation(locations: [Location]) -> [Location] {
        var newLocations = locations
        newLocations.append(
            Location(title: "Box 5 (Verme)", coordinate: CLLocationCoordinate2D(latitude: -20.8271063, longitude: -49.3889255))
        )

        return newLocations
    }
}

extension Array {
    mutating func appendLocation(location: Location) {
        self.append(location as! Element)
    }
}
