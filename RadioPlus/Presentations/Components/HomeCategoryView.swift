//
//  HomeCategoryView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation
import SwiftUI

enum HomeCategoryViewType {
    case miniatureCard
    case verticalCard
    case fullwidthCard
}

enum HomeCategoryView: View, Identifiable {
    var id: UUID { .init() }
//    case podcast(Shows)
//    case foryou(Shows)
//    case favorites(Shows)
//    case latest(Shows)
//    case today(Shows)
//    case chaine(Brands)
//    case live(Live)
    
    case live(title: String, categoryMode: HomeCategoryViewType, Live)
    case shows(title: String, categoryMode: HomeCategoryViewType, shows: Shows)
    
    @ViewBuilder
    var body: some View {
        switch self {
            case .live(let title, let categoryMode, let live):
//                buildWithCustomHeader(header: title, categoryMode: categoryMode, shows: <#T##Shows#>)
                Text("asd")
            case .shows(let title, let categoryMode, let shows):
                buildWithCustomHeader(header: title, categoryMode: categoryMode, shows: shows)
//            case .podcast(let shows):
//                buildPodcast(shows: shows)
//            case .foryou(let shows):
//                buildForYou(shows: Shows)
//            case .favorites(let shows):
//                buildFavorites(shows: shows)
//            case .latest(let shows):
//                buildLatest(shows: shows)
//            case .today(let shows):
//                buildToday(shows: shows)
//            case .chaine(let brands):
//                buildChannels(brands: brands)
//            case .live(let live):
//                buildLive(live: live)
        }
    }
    
    @ViewBuilder
    func buildWithCustomHeader(header: String, categoryMode: HomeCategoryViewType, shows: Shows) -> some View {
        VStack (alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(shows) { show in
                        switch categoryMode {
                            case .miniatureCard:
                                MiniatureCardView(viewMode: .color(.random()), text: .constant(show.title ?? "N/A"))
                            case .verticalCard:
                                VerticalCardView(viewMode: .color(.random()),
                                                 title: .constant(show.title!),
                                                 subtitle: .constant(""))
                            case .fullwidthCard:
                                FullWidthCard(viewMode: .color(.random()), title: .constant(show.title ?? ""), subtitle: .constant(""))
                        }
                    }
                }
            }
        }
    }
    
}
