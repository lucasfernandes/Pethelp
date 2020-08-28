//
//  User.swift
//  PetHelp
//
//  Created by Lucas Silveira on 24/08/20.
//

import Foundation

struct User: Codable {
    var name: String
    var email: String
    var picture: Picture
}

struct Picture: Codable {
    var data: PictureData
}

struct PictureData: Codable {
    var width: Double
    var height: Double
    var url: String
}
