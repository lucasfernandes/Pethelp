//
//  LocationsRepository.swift
//  PetHelp
//
//  Created by Lucas Silveira on 27/09/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol LocationRepository {
    func get(completionHandler: @escaping (Result<[Location], Error>) -> Void)
}

class LocationsRepo: LocationRepository {
    private let storage = Storage.storage().reference()
    private let firebaseDB = Firestore.firestore()

    func get(completionHandler: @escaping (Result<[Location], Error>) -> Void) {
        firebaseDB.collection("/locations").getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                completionHandler(.failure(error!))
                return
            }

            let locations = documents.compactMap { querySnapshot -> Location? in
                let locationDTO = try? querySnapshot.data(as: LocationDTO.self)
                return Location.init(locationDTO: locationDTO!)
            }

            completionHandler(.success(locations))
        }
    }
}
