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
    var onSelect: (() -> Void)? = {}

    var body: some View {
        ScrollView() {
            ForEach(results, id: \.self) { result in
                VStack(spacing: 4) {
                    Button(action: {
                        selectedFragment = result.title
                        (onSelect ?? {})()
                    }) {
                        VStack {
                            if results.first != result {
                                Divider().background(Color("listItemLightGray")).padding(.bottom, 10)
                            }
                            Text(result.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.body)
                                .foregroundColor(.primary)
                            Text(result.subtitle)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 20)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
    }
}

struct SearchResultsListview_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsListView(results: .constant([]), selectedFragment: .constant(""))
    }
}
