//
//  DetailsBrandCategoryView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import SwiftUI

enum DetailsBrandCategoryTypeView {
    case info(title: String, content: String)
    case radios(title: String, radios: Radios, viewType: CategoryViewType)
}

struct DetailsBrandCategoryView: View, Identifiable {
    
    var id: UUID { .init() }
    var type: DetailsBrandCategoryTypeView
    
    @ViewBuilder
    var body: some View {
        switch type {
            case .info(let title, let content):
                buildInfoView(header: title, content: content)
            case .radios(let title, let radios, let viewType):
                buildRadiosInfoView(header: title, categoryMode: viewType, radios: radios)
        }
    }
    
    @ViewBuilder
    func buildRadiosInfoView(header: String, categoryMode: CategoryViewType, radios: Radios) -> some View {
        VStack (alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(radios) { show in
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
    
    @ViewBuilder
    func buildInfoView(header: String, content: String) -> some View {
        VStack (alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
            Text(content)
                .font(.body)
        }
        .padding(.horizontal)
    }
    
}

struct DetailsBrandCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsBrandCategoryView(type: .info(title: "Test head", content: "Test content"))
    }
}
