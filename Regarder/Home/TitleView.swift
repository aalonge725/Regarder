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
        VStack {
            if title.progress == .watching {
                Text("In progress")
                    .foregroundStyle(.red)
                    .bold()
            }
            
            Text(title.title)
                .bold()
                .font(.title2)
                .multilineTextAlignment(.center)
            
            AsyncImage(url: URL(string: title.posterPicture)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 8)
                        .padding()
                        .background {
                            if !title.isMovie {
                                RoundedRectangle(cornerRadius: 20)
                                    .padding()
                                    .offset(x: 10, y: -10)
                                    .shadow(radius: 8)
                                    .foregroundStyle(.ultraThinMaterial)
                            }
                                
                        }
                } else if phase.error != nil {
                    VStack {
                        Image(systemName: title.isMovie ? "film" : "film.stack")
                            .imageScale(.large)
                        
                        Text("Error loading image")
                            .bold()
                    }
                    .padding()
                    .background(.white)
                    .foregroundStyle(.red)
                } else {
                    VStack {
                        Image(systemName: title.isMovie ? "film" : "film.stack")
                            .imageScale(.large)
                        
                        ProgressView()
                    }
                    .padding()
                    .background(.white)
                    .foregroundStyle(.accent)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Watched: ").bold() +
                Text(title.dateWatched ?? "unknown")
                
                Text("Aired: ").bold() +
                Text(title.getDateReleasedString())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
        }
        .padding(8)
        .foregroundColor(.white)
        .background(.customDark)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 8)
    }
}

#Preview {
    TitleView(title: Title(id: "1", title: "Avengers: Infinity War", isMovie: true, dateWatched: "junior or senior year high school?", dateReleased: Date(), posterPicture: "https://i.ebayimg.com/images/g/VpQAAOSwHvpa7zbY/s-l400.jpg", progress: .watching))
}
