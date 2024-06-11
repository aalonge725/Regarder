//
//  TitleView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/8/24.
//

import SwiftUI

struct TitleView: View {
    @State var title: Title
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TitleView(title: Title(id: "1", title: "Avengers: Infinity War", isMovie: true, dateWatched: "junior or senior year high school?", dateReleased: Date(), posterPicture: "https://i.ebayimg.com/images/g/VpQAAOSwHvpa7zbY/s-l400.jpg", progress: .watched))
}
