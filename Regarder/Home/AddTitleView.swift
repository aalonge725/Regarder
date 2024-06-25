//
//  AddTitleView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/20/24.
//

import SwiftUI

struct AddTitleView: View {
    @EnvironmentObject var titlesViewModel: TitlesViewModel
    @StateObject private var vm = AddTitleViewModel()
    @Binding var isAddTitleSheetShowing: Bool
    @State private var isInvalidSearchAlertShowing = false
    @State private var isSearchRequestErrorAlertShowing = false
    @State private var showSearchBar = true
    @State private var showDateWatchedView = false
    @State private var dateWatchedTextFieldText = ""
    @State private var selectedTitle: Title? = nil
    
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
                
                if showDateWatchedView {
                    dateWatchedView
                }
            }
            .navigationTitle("Add Title")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $vm.searchText,  prompt: "Search for a title")
            .toolbar(showSearchBar ? .visible : .hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isAddTitleSheetShowing = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
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
                        vm.searchResultTitles = response.titles.map {
                            TitleMapper.titleFromOMDbAPI(title: $0, progress: .unspecified, dateWatched: nil)
                        }
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
            Menu {
                Section("Select progress") {
                    ForEach(TitleProgress.allCases, id: \.self) { titleProgress in
                        Button(titleProgress.rawValue, action: {
                            selectedTitle = title
                            
                            if titleProgress == .watched {
                                showDateWatchedView = true
                                showSearchBar = false
                            } else {
                                addSelectedTitle(progress: titleProgress)
                            }
                        })
                    }
                }
            } label: {
                TitleView(title: title, titleViewType: .OMDbTitle)
            }
        }
    }
    
    private var dateWatchedView: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    showDateWatchedView = false
                    showSearchBar = true
                    dateWatchedTextFieldText = ""
                }
            
            TextField("Enter when you watched the title", text: $dateWatchedTextFieldText)
                .textInputAutocapitalization(.never)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8).fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.accentColor, lineWidth: 2)
                )
                .padding()
                .onSubmit {
                    addSelectedTitle(progress: .watched)
                    showDateWatchedView = false
                    showSearchBar = true
                }
        }
    }
    
    private func addSelectedTitle(progress: TitleProgress) { // TODO: prevent addition of duplicates
        if var selectedTitle = selectedTitle {
            if progress == .watched {
                selectedTitle.setDateWatched(date: dateWatchedTextFieldText)
                dateWatchedTextFieldText = ""
            }
            
            selectedTitle.updateProgress(progress: progress)
            titlesViewModel.addTitle(title: selectedTitle)
            self.selectedTitle = nil
        }
    }
}

#Preview {
    AddTitleView(isAddTitleSheetShowing: .constant(true))
}
