//
//  HomeView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/6/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @State private var searchText: String = ""
    @State private var isAddTitleSheetShowing = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customLight
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        ForEach(filteredTitles) { title in
                            TitleView(title: title, titleViewType: .homeViewTitle)
                        }
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
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
            .fullScreenCover(isPresented: $isAddTitleSheetShowing, onDismiss: didDismiss, content: {
                AddTitleView(isAddTitleSheetShowing: $isAddTitleSheetShowing)
            })
        }
    }
    
    func didDismiss() {
        // TODO: refresh title list
    }
    
    var filteredTitles: [Title] {
            if searchText.isEmpty {
                return vm.titles
            } else {
                return vm.titles.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
    private var header: some View {
        HStack {
            Text("\(vm.titles.count) titles")
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
                    // TODO: implement title addition logic
                    isAddTitleSheetShowing = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
