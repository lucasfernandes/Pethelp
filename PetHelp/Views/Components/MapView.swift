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
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool

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

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true

                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

            guard let placemark = view.annotation as? MKPointAnnotation else { return }

            parent.selectedPlace = placemark
            parent.showingPlaceDetails = true
        }
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
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
                selectedLocation: .constant(CLLocationCoordinate2D()),
                selectedPlace: .constant(nil),
                showingPlaceDetails: .constant(false),
                annotations: [MKPointAnnotation.example],
                region: MKCoordinateRegion())
    }
}
