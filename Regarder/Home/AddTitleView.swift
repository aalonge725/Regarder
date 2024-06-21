//
//  AddTitleView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/20/24.
//

import SwiftUI

struct AddTitleView: View {
    @StateObject var vm = AddTitleViewModel()
    @Binding var isAddTitleSheetShowing: Bool
    @State private var isInvalidSearchAlertShowing = false
    @State private var isSearchRequestErrorAlertShowing = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customLight
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        if vm.searchText.isEmpty { // TODO: fix weird animation when searchText goes from non-empty to empty
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
            .searchable(text: $vm.searchText, prompt: "Search for a movie or tv show")
            .onChange(of: vm.debouncedText) { oldText, newText in
                if newText.isEmpty {
                    return
                }
                
                // TODO: check if newText is alphanumeric
                
                guard let url = URL(string: "https://www.omdbapi.com/?apikey=4ac97843&s=\(newText)") else {
                    isInvalidSearchAlertShowing = true
                    return
                }
                
                Task {
                    do {
                        let response = try await NetworkManager.get(url: url, responseType: OMDbAPISearchResult.self) // TODO: make model for failed search result (ex. too many results or movie not found)
                        vm.searchResultTitles = response.titles
                    } catch {
                        vm.searchRequestErrorDescription = error.localizedDescription
                        isSearchRequestErrorAlertShowing = true
                    }
                }
                
            }
            .alert("Invalid Search Query", isPresented: $isInvalidSearchAlertShowing) {} message: {
                Text("Please only enter letters and/or numbers into the search bar")
            }
            .alert("Search Request Error", isPresented: $isSearchRequestErrorAlertShowing) {} message: {
                Text("\(vm.searchRequestErrorDescription)")
            }
        }
    }
    
    private var searchResultTitlesList: some View {
        ForEach(vm.searchResultTitles) { title in
            // TODO: make list
        }
    }
}

#Preview {
    AddTitleView(isAddTitleSheetShowing: .constant(true))
}
