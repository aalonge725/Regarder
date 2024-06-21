//
//  AddTitleView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/20/24.
//

import SwiftUI

struct AddTitleView: View {
    @Binding var isAddTitleSheetShowing: Bool
    @State private var searchResultTitles: [OMDbAPITitle] = []
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customLight
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        if searchText.isEmpty { // TODO: fix weird animation when searchText goes from non-empty to empty
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                                .font(.system(size: 50))
                                .padding()
                                .foregroundStyle(.accent)
                            
                            Text("Please use the search bar to search for a movie or tv show")
                                .multilineTextAlignment(.center)
                                .bold()
                                .font(.title2)
                                .foregroundStyle(.accent)
                        } else {
                            searchResultTitlesList
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add Title")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isAddTitleSheetShowing = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for a movie or tv show")
        }
    }
    
    private var searchResultTitlesList: some View {
        ForEach(searchResultTitles) { title in
            // TODO: make list
        }
    }
}

#Preview {
    AddTitleView(isAddTitleSheetShowing: .constant(true))
}
