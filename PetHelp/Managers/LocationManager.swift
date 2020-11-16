//
//  LocationManager.swift
//  PetHelp
//
//  Created by Lucas Silveira on 28/08/20.
//

import Foundation
import MapKit
import CoreLocation
import FirebaseFirestore

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let completer: MKLocalSearchCompleter = MKLocalSearchCompleter()

    @Published var region = MKCoordinateRegion()
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var annotations: [Location] = []
    @Published var locations: [MKPointAnnotation] = []
    @Published var locationFound: Location?
    @Published var selectedFragment: String = "" {
        didSet {
            selectedFragment.isEmpty
                ? searchResults = []
                : self.search(text: selectedFragment)
        }
    }

    private var currentCoordinate: CLLocation!
    var collectionRef: CollectionReference!
    var geoFirestore: GeoFirestore!
    var sfQuery: GFSQuery!

    override init() {
        super.init()

        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()

        self.completer.delegate = self
        self.completer.region = self.region

        self.getCurrentLocation()
        self.configGeoFire()
        self.getLocations()
//        self.getAllLocations()
//        self.getLocations()
    }

    private func configGeoFire() {
        collectionRef = Firestore.firestore().collection("geoloc-test")

        //creates the geoFirestore object and point it to a Firestore collection reference containing documents to geoquery on
        geoFirestore = GeoFirestore(collectionRef: collectionRef)

        //queries for everything within 1 km of central SF
        sfQuery = geoFirestore.query(withCenter: currentCoordinate, radius: 50.0)
    }

    private func getAllLocations() {
        let repository = LocationsRepo()
        repository.get { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let locations):
                for location in locations {
                    self.annotations.append(location)

                    let newLocation = MKPointAnnotation()
                    newLocation.title = location.title
                    newLocation.coordinate = location.place.coordinate
                    self.locations.append(newLocation)
                }
            }
        }
    }

    public func setLocation(coordinate2D: CLLocationCoordinate2D) {
        //uploads to Firestore
        let location = CLLocation(latitude: coordinate2D.latitude, longitude: coordinate2D.longitude)
        geoFirestore.setLocation(location: location, forDocumentWithID: collectionRef.document().documentID) { (err) in
            if let error = err {
                print("ERROR CREATING DOCUMENT")
                print(error)
            }
        }
    }

    public func getLocations() {
        _ = sfQuery.observe(.documentEntered, with: { (key, location) in
            if let key = key, let loc = location {
                let newLocation = MKPointAnnotation()
                newLocation.title = key
                newLocation.coordinate = loc.coordinate
                self.locations.append(newLocation)
            }
        })

//        uses Handles to remove queries
//        _ = sfQuery.observe(.documentExited, with: { (key, location) in
//            if let key = key {
//                if let ann =
//                    self.mapView.annotations.first(where: { (annotation) -> Bool in
//                        return annotation.title == key
//                    })
//                {
//                    DispatchQueue.main.async {
//                        self.mapView.removeAnnotation(ann)
//                    }
//                    print("Removed \(key)!")
//                }
//            }
//        })
    }
}

extension LocationManager {
    private func makeRegion(coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: coordinate.latitude,
                                           longitude: coordinate.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }

    func getCurrentLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        region = makeRegion(coordinate: coordinate)
        currentCoordinate = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }

    func search(text: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = self.region

        let search = MKLocalSearch(request: searchRequest)

        search.start { response, _ in
            guard let response = response else { return }

            for item in response.mapItems {
                DispatchQueue.main.async {
                    self.locationFound = Location(
                        id: UUID().description,
                        title: item.name ?? "No name found",
                        coordinate: CLLocationCoordinate2D(
                            latitude: item.placemark.coordinate.latitude,
                            longitude: item.placemark.coordinate.longitude),
                        place: item.placemark)

                    self.annotations.append(self.locationFound!)

                    let newLocation = MKPointAnnotation()
                    newLocation.title = item.name ?? ""
                    newLocation.coordinate = item.placemark.coordinate
                    self.locations.append(newLocation) // the map loads it after onReceive -> LocationsView
                }
            }
        }
    }
}

extension LocationManager: MKLocalSearchCompleterDelegate {
    func autoCompletedSearch(text: String) {
        completer.queryFragment = text
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results
    }
}
