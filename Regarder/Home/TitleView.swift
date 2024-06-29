//
//  TitleView.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/8/24.
//

import SwiftUI

struct TitleView: View {
    @State var title: Title
    @State var titleViewType: TitleViewType
    
    var body: some View {
        VStack {
            if titleViewType == .homeViewTitle && title.progress == .watching {
                Text(TitleProgress.watching.rawValue)
                    .foregroundStyle(.red)
                    .bold()
            }
            
            Text(title.title)
                .bold()
                .font(titleFont)
                .multilineTextAlignment(.center)
            
            AsyncImage(url: URL(string: title.posterPicture)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: posterMaxWidth)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 8)
                        .padding()
                        .background {
                            if title.type == .series {
                                RoundedRectangle(cornerRadius: 20)
                                    .padding()
                                    .offset(x: 10, y: -10)
                                    .shadow(radius: 8)
                                    .foregroundStyle(.ultraThinMaterial)
                            }
                                
                        }
                } else if phase.error != nil {
                    VStack {
                        Image(systemName: title.type == .movie ? "film" : "film.stack")
                            .imageScale(.large)
                        
                        Text("Error loading image")
                            .bold()
                    }
                    .padding()
                    .background(.white)
                    .foregroundStyle(.red)
                } else {
                    VStack {
                        Image(systemName: title.type == .movie ? "film" : "film.stack")
                            .imageScale(.large)
                        
                        ProgressView()
                    }
                    .padding()
                    .background(.white)
                    .foregroundStyle(.accent)
                }
            }
            
            VStack(alignment: .leading) {
                if titleViewType == .homeViewTitle {
                    Text("Watched: ").bold() +
                    Text((title.dateWatched == nil || title.dateWatched!.isEmpty) ? "unknown" : title.dateWatched!)
                }
                
                Group {
                    Text("Aired: ").bold() +
                    Text(title.dateReleased)
                }
                .frame(maxWidth: .infinity, alignment: titleViewType == .OMDbTitle ? .center : .leading)
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
    
    private var posterMaxWidth: CGFloat {
        switch titleViewType {
        case .homeViewTitle:
            return .infinity
        case .OMDbTitle:
            return UIScreen.main.bounds.size.width / 3
        }
    }
    
    private var titleFont: Font {
        switch titleViewType {
        case .homeViewTitle:
            return  .title2
        case .OMDbTitle:
            return .title3
        }
    }
}

enum TitleViewType {
    case homeViewTitle
    case OMDbTitle
}

#Preview {
    TitleView(title: Title(id: "1", title: "Avengers: Infinity War", type: .movie, dateWatched: "junior or senior year high school?", dateReleased: Date().formatted(date: .long, time: .omitted), posterPicture: "https://i.ebayimg.com/images/g/VpQAAOSwHvpa7zbY/s-l400.jpg", progress: .watching), titleViewType: .OMDbTitle)
}
