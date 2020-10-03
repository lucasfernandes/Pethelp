//
//  SearchResultsListview.swift
//  PetHelp
//
//  Created by Lucas Silveira on 30/08/20.
//

import SwiftUI
import MapKit

struct SearchResultsListView: View {
    @Binding var results: [MKLocalSearchCompletion]
    @Binding var selectedFragment: String
    var onSelect: (() -> Void)?

    var body: some View {
        ScrollView {
            ForEach(results, id: \.self) { result in
                VStack(spacing: 4) {
                    Button(action: {
                        selectedFragment = result.title
                        (onSelect ?? {})()}) {
                        VStack {
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(Color("searchListCallout"))
                                    .padding(.trailing)
                                VStack {
                                    Text(result.title)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.title3)
                                        .foregroundColor(.primary)
                                    Text(result.subtitle)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Divider().background(Color("listItemOpaqueLightGray")).padding(.bottom, 10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

struct SearchResultsListview_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsListView(results: .constant([]), selectedFragment: .constant(""))
    }
}
