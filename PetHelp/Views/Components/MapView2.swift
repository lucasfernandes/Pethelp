//
//  MapView.swift
//  PetHelp
//
//  Created by Lucas Silveira on 28/08/20.
//

import SwiftUI
import MapKit

struct MapView2: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var locationManager = LocationManager()
    @State private var search = ""
    @State private var trackingMode = MapUserTrackingMode.follow
    @State var viewState: BottomSheetViewState = .peek

    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $locationManager.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: $locationManager.annotations.wrappedValue) { location in
                    MapAnnotation(coordinate: location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                        MapAnnotationView(name: location.title, image: Image("dog"))
                    }
                }

            BottomSheet(viewState: self.$viewState) {
                VStack {
                    SearchBar(placeholder: "Procure um local", onEditingChanged: {
                        if $search.wrappedValue.count > 3 {
                            locationManager.autoCompletedSearch(text: $search.wrappedValue)
                        }
                    }, text: $search)
                    .padding(.horizontal, 10)

                    if $locationManager.searchResults.wrappedValue.isEmpty {
//                        AnnotationsListView(
//                            annotations: $locationManager.annotations,
//                            onSelect: {}
//                        )
//                        .frame(alignment: .top)
                        //
                    } else {
                        SearchResultsListView(
                            results: $locationManager.searchResults,
                            selectedFragment: $locationManager.selectedFragment,
                            onSelect: {
                                self.search = ""
                                self.locationManager.searchResults = []
                                self.viewState = .peek
                            }).frame(alignment: .top)
                    }
                }
                .edgesIgnoringSafeArea(.vertical)
            }

        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Incluir novo", displayMode: .inline)
        //            .navigationBarItems(trailing: Button(action: {
        //                self.presentationMode.wrappedValue.dismiss()
        //            }) {
        //                Image(systemName: "xmark.circle")
        //                    .font(Font.system(.headline))
        //            })
        //        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView2()
    }
}
