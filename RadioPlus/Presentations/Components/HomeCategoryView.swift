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

//enum HomeCategoryView: SearchableProtocol {
//    var title: String? {
//        return
//    }
//}

enum HomeCategoryView: View, Identifiable, SearchableProtocol {
    
    func getSearchableContent() -> [String] {
        switch self {
            case .brand(_, let brands):
                return brands.compactMap { $0.title }
            case .live(_, let live):
                return [live.song, live.program].compactMap { $0 }
            case .shows(_,_, let shows):
                return shows.compactMap { $0.title }
        }
    }
    
    var id: UUID { .init() }
    
    case brand(title: String, brands: Brands)
    case live(title: String, live: Live)
    case shows(title: String, categoryMode: HomeCategoryViewType, shows: Shows)
    
    @ViewBuilder
    var body: some View {
        switch self {
            case .brand(let title, let brands):
                buildBrandsView(header: title, brands: brands)
            case .live(let title, let live):
                buildLiveView(header: title, live: live)
            case .shows(let title, let categoryMode, let shows):
                buildShowsWithCustomHeader(header: title, categoryMode: categoryMode, shows: shows)
        }
    }
    
    @ViewBuilder
    func buildBrandsView(header: String, brands: Brands) -> some View {
        VStack (alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(brands) { brand in
                        MiniatureCardView(viewMode: .color(.random()), text: .constant(brand.title ?? ""))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    func buildLiveView(header: String, live: Live) -> some View {
        VStack (alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
            
            FullWidthCard(viewMode: .color(.random()), title: .constant(live.show?.title ?? ""), subtitle: .constant(live.song ?? ""))
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    func buildShowsWithCustomHeader(header: String, categoryMode: HomeCategoryViewType, shows: Shows) -> some View {
        VStack (alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
                .padding(.horizontal)
            
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
                .padding(.horizontal)
            }
        }
    }
}
