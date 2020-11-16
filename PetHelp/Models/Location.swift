//
//  Location.swift
//  PetHelp
//
//  Created by Lucas Silveira on 30/08/20.
//

import Foundation
import MapKit

public struct Location: Identifiable {
    public var id: String
    public var title: String
    public var coordinate: CLLocationCoordinate2D
    public var place: MKPlacemark
}

extension Array {
    mutating func appendLocation(location: Location) {
        self.append(location as! Element)
    }
}
