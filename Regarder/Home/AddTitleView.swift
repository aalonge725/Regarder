//
//  AddTitleView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/20/24.
//

import SwiftUI

struct AddTitleView: View {
    @EnvironmentObject var titlesViewModel: TitlesViewModel
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
                            
                            Text("Please use the search bar to search for a movie or tv show to add to your list")
                                .multilineTextAlignment(.center)
                                .bold()
                                .font(.title2)
                                .foregroundStyle(.accent)
                        } else {
                            searchResultTitlesList
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
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
            .searchable(text: $vm.searchText, prompt: "Search for a title to add to your list")
            .onChange(of: vm.searchText) { oldText, newText in
                vm.searchResultTitles.removeAll()
            }
            .onChange(of: vm.debouncedText) { oldText, newText in
                if newText.isEmpty {
                    return
                }
                
                // TODO: check if newText is alphanumeric; handle allowed non-alphanumeric chars like spaces and ampersands
                
                // TODO: change and securely store API key
                
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
        ForEach(vm.searchResultTitles) { title in // TODO: refactor - make TItleTransformer class
            Menu {
                Section("Select progress") {
                    ForEach(TitleProgress.allCases, id: \.self) { titleProgress in
                        Button(titleProgress.rawValue, action: {} /* TODO: add selected title to titles list */)
                    }
                }
            } label: {
                TitleView(title: Title(id: title.id, title: title.title, isMovie: title.type == .movie, dateWatched: nil, dateReleased: title.year, posterPicture: title.poster, progress: .unspecified), titleViewType: .OMDbTitle)
            }
        }
    }
}

#Preview {
    AddTitleView(isAddTitleSheetShowing: .constant(true))
}
