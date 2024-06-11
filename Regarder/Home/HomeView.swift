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
                Color.customDark
                    .ignoresSafeArea()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    header
                }
            }
        }
    }
        
    private var header: some View {
        HStack {
            Text("\(vm.titles.count) titles")
                .bold()
                .foregroundStyle(.accent)
                .padding(12)
                .background(.customLight)
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
            .background(.customLight)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 8)
                
            Button {
                // TODO: implement title addition logic
            } label: {
                Image(systemName: "plus")
                    .padding(11)
                    .background(.customLight)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 8)
            }
        }
    }
}

#Preview {
    HomeView()
}
