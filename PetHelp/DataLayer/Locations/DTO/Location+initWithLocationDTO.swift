//
//  Location+initWithLocationDTO.swift
//  PetHelp
//
//  Created by Lucas Silveira on 27/09/20.
//

import Foundation
import MapKit
import Contacts

extension Location {
    static func makeCoordinates(locationDTO: LocationDTO) -> CLLocationCoordinate2D {
        let latitude = CLLocationDegrees(locationDTO.coordinate.latitude)
        let longitude = CLLocationDegrees(locationDTO.coordinate.longitude)
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func makePlaceMark(coordinate: Coordinate, address: Address) -> MKPlacemark {
        let coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let address = [
            CNPostalAddressCityKey: address.CNPostalAddressCityKey,
            CNPostalAddressCountryKey: address.CNPostalAddressCountryKey,
            CNPostalAddressISOCountryCodeKey: address.CNPostalAddressISOCountryCodeKey,
            CNPostalAddressPostalCodeKey: address.CNPostalAddressPostalCodeKey,
            CNPostalAddressStateKey: address.CNPostalAddressStateKey,
            CNPostalAddressStreetKey: address.CNPostalAddressStreetKey,
            CNPostalAddressSubAdministrativeAreaKey: address.CNPostalAddressSubAdministrativeAreaKey,
            CNPostalAddressSubLocalityKey: address.CNPostalAddressSubLocalityKey
        ]

        let place = MKPlacemark(
            coordinate: coordinate,
            addressDictionary: address)
        return place
    }

    init(locationDTO: LocationDTO) {
        id = locationDTO.id!
        title = locationDTO.title
        coordinate = Location.makeCoordinates(locationDTO: locationDTO)
        place = Location.makePlaceMark(coordinate: locationDTO.coordinate, address: locationDTO.address)
    }
}
