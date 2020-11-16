//
//  PetDTO.swift
//  PetHelp
//
//  Created by Lucas Silveira on 01/10/20.
//

import Foundation
import FirebaseFirestoreSwift

public struct PetDTO: Codable {
    @DocumentID var id: String?
    public var race: String
    public var name: String
    public var description: String
    public var document: String
    public var agency: String
    public var account: String
    public var locations: [String]?
}
