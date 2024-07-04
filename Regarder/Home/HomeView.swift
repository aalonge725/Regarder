//
//  HomeView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/6/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var titlesViewModel: TitlesViewModel
    @State private var searchText: String = ""
    @State private var isAddTitleSheetShowing = false
    @State private var selectedProgressType: ProgressPickerType = .all
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customLight
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        Picker("Progress Picker Type", selection: $selectedProgressType) {
                            ForEach(ProgressPickerType.allCases, id: \.self) { progress in
                                Text(progress.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        ForEach(filteredTitles()) { title in
                            TitleView(title: title, titleViewType: .homeViewTitle)
                        }
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                }
            }
            .onAppear {
                titlesViewModel.fetchTitles()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        header
                        
                        Spacer()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search for a movie or tv show")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isAddTitleSheetShowing, content: {
                AddTitleView(isAddTitleSheetShowing: $isAddTitleSheetShowing)
            }) // TODO: add refreshable that force fetches Titles documents
        }
    }
        
    func filteredTitles() -> [Title] {
        var titles: [Title] = []
        
        switch selectedProgressType {
        case .all:
            titles = titlesViewModel.getTitles()
        case .started:
            titles = titlesViewModel.getTitles().filter { $0.progress == .watched || $0.progress == .watching }
        case .notStarted:
            titles = titlesViewModel.getTitles().filter { $0.progress == .notStarted }
        }
        
        return searchText.isEmpty ? titles : titles.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
        
    private var header: some View {
        HStack {
            Text(titlesViewModel.getTitles().count == 1 ? "1 title" : "\(titlesViewModel.getTitles().count) titles")
                .bold()
                .foregroundStyle(.accent)
                .padding(8)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 8)
                .padding(.leading, 2)
            
            Spacer()
            
            HStack(spacing: -10) {
                Button {
                    // TODO: implement sorting logic
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
                
                Button {
                    // TODO: implement filtering logic
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
            .frame(maxHeight: 36)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 8)
                
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .shadow(radius: 8)
                
                Button {
                    isAddTitleSheetShowing = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

enum ProgressPickerType: String, CaseIterable {
    case all = "All"
    case started = "Started"
    case notStarted = "Not Started"
}

#Preview {
    HomeView()
        .environmentObject(TitlesViewModel())
}
