//
//  HomeCategoryView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation
import SwiftUI

enum CategoryViewType {
    case miniatureCard
    case verticalCard
    case fullwidthCard
}

enum HomeCategoryTypeView {
    case brand(title: String, brands: Brands)
    case live(title: String, live: Live)
    case shows(title: String, categoryMode: CategoryViewType, shows: Shows)
    case carousel(shows: Shows)
}

struct HomeCategoryView: View, Identifiable, SearchableProtocol {
    
    @EnvironmentObject var factory: ViewModelFactory
    
    var id: UUID { .init() }
    var type: HomeCategoryTypeView
    
    func getSearchableContent() -> [String] {
        switch type {
            case .brand(_, let brands):
                return brands.compactMap { $0.title }
            case .live(_, let live):
                return [live.song, live.show?.title].compactMap { $0 }
            case .shows(_,_, let shows):
                return shows.compactMap { $0.title }
            case .carousel(shows: let shows):
                return shows.compactMap { $0.title }
        }
    }
    
    @ViewBuilder
    var body: some View {
        switch type {
            case .carousel(let shows):
                buildCarouselView(shows: shows)
            case .brand(let title, let brands):
                buildBrandsView(header: title, brands: brands)
            case .live(let title, let live):
                NavigationLink(destination: DetailsLiveView(viewModel: factory.buildLiveViewModel(live: live))){
                    buildLiveView(header: title, live: live)
                }
            case .shows(let title, let categoryMode, let shows):
                buildShowsWithCustomHeader(header: title, categoryMode: categoryMode, shows: shows)
        }
    }
    @ViewBuilder
    func buildCarouselView(shows: Shows) -> some View {
        Canvas {
            Carousel(
                numberOfItems: CGFloat(shows.count),
                spacing: 10,
                widthOfHiddenCards: 50
            ) {
                ForEach(shows, id: \.self.id) { show in
                    Item(
                        _id: Int(Int.random(in: 0...200)),
                        spacing: 10,
                        widthOfHiddenCards: 50,
                        cardHeight: 250
                    ) {
                        NavigationLink(destination: DetailsShowView(viewModel: factory.buildShowViewModel(show: show))) {
                            FullWidthCard(viewMode: .image(.randomImageName()), title: .constant(show.title ?? ""), subtitle: .constant(""))
                        }
                    }
                    .cornerRadius(8)
                    .transition(AnyTransition.slide)
                    .animation(.spring())
                }
            }
        }
        .environmentObject(UIStateModel())
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
                        NavigationLink(destination: DetailBrandView(viewModel: factory.buildBrandViewModel(brand: brand))){
                            MiniatureCardView(viewMode: .color(.random()), text: .constant(brand.title ?? ""))
                        }
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
    func buildShowsWithCustomHeader(header: String, categoryMode: CategoryViewType, shows: Shows) -> some View {
        VStack (alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(shows) { show in
                        NavigationLink(destination: DetailsShowView(viewModel: factory.buildShowViewModel(show: show))) {
                            switch categoryMode {
                                case .miniatureCard:
                                    MiniatureCardView(viewMode: .color(.random()), text: .constant(show.title ?? "N/A"))
                                case .verticalCard:
                                    VerticalCardView(viewMode: .image(.randomImageName()),
                                                     title: .constant(show.title!),
                                                     subtitle: .constant(""))
                                case .fullwidthCard:
                                    FullWidthCard(viewMode: .color(.random()), title: .constant(show.title ?? ""), subtitle: .constant(""))
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
