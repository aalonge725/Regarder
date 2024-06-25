//
//  TitlesViewModel.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/8/24.
//

import Foundation

class TitlesViewModel: ObservableObject {
    @Published private var titles: [Title] = []
    
    init() {
        titles = getMockTitles()
    }
    
    private func getMockTitles() -> [Title] {
        return [Title(id: "1", title: "Avengers: Infinity War", isMovie: true, dateWatched: "junior or senior year high school?", dateReleased: Date().formatted(date: .long, time: .omitted), posterPicture: "https://i.ebayimg.com/images/g/VpQAAOSwHvpa7zbY/s-l400.jpg", progress: .watched),
                Title(id: "2", title: "The Office", isMovie: false, dateWatched: nil, dateReleased: Date().formatted(date: .long, time: .omitted), posterPicture: "https://i.ebayimg.com/images/g/VpQAAOSwHvpa7zbY/s-l400.jpg", progress: .watching),
                Title(id: "3", title: "Interstellar", isMovie: true, dateWatched: nil, dateReleased: Date().formatted(date: .long, time: .omitted), posterPicture: "https://i.ebayimg.com/images/g/VpQAAOSwHvpa7zbY/s-l400.jpg", progress: .watched),
                Title(id: "4", title: "Pair of Kings", isMovie: false, dateWatched: "elementary school", dateReleased: Date().formatted(date: .long, time: .omitted), posterPicture: "https://i.ebayimg.com/images/g/VpQAAOSwHvpa7zbY/s-l400.jpg", progress: .watched)]
    }
    
    func getTitles() -> [Title] {
        return titles
    }
    
    func addTitle(title: Title) {
        titles.append(title)
    }
}
