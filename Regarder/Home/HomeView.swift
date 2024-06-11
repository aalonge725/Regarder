//
//  HomeView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/6/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.customLight
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        ForEach(vm.titles) { title in
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
            .padding(.vertical, 5)
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
