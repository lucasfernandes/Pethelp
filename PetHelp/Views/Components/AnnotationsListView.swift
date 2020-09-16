//
//  AnnotationsListView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 05/09/20.
//

import SwiftUI
import MapKit


struct AnnotationsListView: View {
    @Binding var annotations: [Location]
    @Binding var selectedLocation: CLLocationCoordinate2D?
    
    var onSelect: (() -> Void)? = {}

    var body: some View {
        ScrollView() {
            ForEach(annotations) { annotation in
                VStack(spacing: 4) {
                    Button(action: {
                        (onSelect ?? {})()
                        selectedLocation = annotation.coordinate
                    }) {
                        VStack(spacing: 3) {
                            Text(annotation.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.body)
                                .foregroundColor(.primary)
                            Text("\(annotation.placemark.thoroughfare ?? ""), \(annotation.placemark.subThoroughfare ?? "") - \(annotation.placemark.subLocality ?? "")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text("\(annotation.placemark.locality ?? "") - \(annotation.placemark.administrativeArea ?? "")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(annotation.placemark.postalCode ?? "") - \(annotation.placemark.administrativeArea ?? ""), \(annotation.placemark.country ?? "")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Divider().background(Color("listItemOpaqueLightGray")).padding(.top, 10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

struct AnnotationsListView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationsListView(annotations: .constant([]), selectedLocation: .constant(CLLocationCoordinate2D()))
    }
}
