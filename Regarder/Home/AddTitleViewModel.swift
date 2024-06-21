//
//  AddTitleViewModel.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/20/24.
//

import Foundation
import Combine

class AddTitleViewModel: ObservableObject {
    @Published var searchResultTitles: [OMDbAPITitle] = []
    @Published var searchText = ""
    @Published var debouncedText = ""
    @Published var searchRequestErrorDescription = ""
    
    init() {
        debounceTextChanges()
    }
    
    func debounceTextChanges() {
        debouncedText = self.searchText
        $searchText
            .debounce(for: .seconds(2), scheduler: RunLoop.main)
            .assign(to: &$debouncedText)

    }
}
