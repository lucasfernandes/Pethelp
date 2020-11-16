//
//  LocationManagerX.swift
//  PetHelp
//
//  Created by Lucas Silveira on 10/10/20.
//

import Foundation
import MapKit
import FirebaseFirestore

class LocationManagerX: NSObject, Mappable {
    var locationManager: CLLocationManager = CLLocationManager()
    var completer: MKLocalSearchCompleter = MKLocalSearchCompleter()

    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var annotations: [Location] = []
    @Published var locations: [MKPointAnnotation] = []
    @Published var locationFound: Location?
    @Published var selectedFragment: String = "" {
        didSet {
            selectedFragment.isEmpty
                ? searchResults = []
                : self.search(text: selectedFragment) { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let items):
                        self.makeLocations(items: items)
                    }
                }
        }
    }

    var currentCoordinate: CLLocation!
    var collectionRef: CollectionReference!
    var geoFirestore: GeoFirestore!
    var sfQuery: GFSQuery!

    override init() {
        super.init()
        self.completer.delegate = self
        self.completer.region = self.region
        self.initLocationManager()
    }
}

extension LocationManagerX: MKLocalSearchCompleterDelegate {
    func autoCompletedSearch(text: String) {
        completer.queryFragment = text
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
    }
}
