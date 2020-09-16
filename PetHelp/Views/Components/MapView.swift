//
//  MapView2.swift
//  PetHelp
//
//  Created by Lucas Silveira on 07/09/20.
//
import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedLocation: CLLocationCoordinate2D?
    var annotations: [MKPointAnnotation]
    var region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        view.setRegion(region, animated: true)
        view.addAnnotations(annotations)

        if !annotations.isEmpty {
            let region = MKCoordinateRegion(center: annotations.last!.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            view.setRegion(region, animated: true)
        }

        if selectedLocation != nil {
            view.centerCoordinate = selectedLocation!
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate, ObservableObject {
        @Published var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func setRegion(coordinate: CLLocationCoordinate2D) {
            self.parent.centerCoordinate = coordinate
        }

//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customView")
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(systemName: "flag.fill")
//            return annotationView
//        }
//        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//            parent.centerCoordinate = mapView.centerCoordinate
//        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct Mapview_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), selectedLocation: .constant(CLLocationCoordinate2D()), annotations: [MKPointAnnotation.example], region: MKCoordinateRegion())
    }
}
