//
//  LocationDTO.swift
//  PetHelp
//
//  Created by Lucas Silveira on 27/09/20.
//

import Foundation
import FirebaseFirestoreSwift

public struct LocationDTO: Codable {
    @DocumentID var id: String?
    public var title: String
    public var coordinate: Coordinate
    public var address: Address
}

public struct Coordinate: Codable {
    public var latitude: Double
    public var longitude: Double
}

public struct Address: Codable {
    public var CNPostalAddressCityKey: String
    public var CNPostalAddressCountryKey: String
    public var CNPostalAddressISOCountryCodeKey: String
    public var CNPostalAddressPostalCodeKey: String
    public var CNPostalAddressStateKey: String
    public var CNPostalAddressStreetKey: String
    public var CNPostalAddressSubAdministrativeAreaKey: String
    public var CNPostalAddressSubLocalityKey: String
}
