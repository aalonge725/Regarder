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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customLight
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        ForEach(filteredTitles) { title in
                            TitleView(title: title)
                        }
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    header
                }
            }
            .toolbarBackground(.hidden)
            .searchable(text: $searchText, prompt: "Search for a movie or tv show")
        }
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
                .padding(12)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 8)
                .padding(.leading, 10)
            
            Spacer()
            
            HStack(spacing: 0) {
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
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 8)
                
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .shadow(radius: 8)
                
                Button {
                    // TODO: implement title addition logic
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
