//
//  DetailsShowCategoryView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import SwiftUI

enum DetailsShowCategoryTypeView {
    case info(title: String, content: String)
    case diffusion(title: String, diffusions: Diffusions, viewType: CategoryViewType)
}

struct DetailsShowCategoryView: View, Identifiable {
    
    var id: UUID { .init() }
    var type: DetailsShowCategoryTypeView
    
    @ViewBuilder
    var body: some View {
        switch type {
            case .info(let title, let content):
                buildInfoView(header: title, content: content)
            case .diffusion(let title, let diffusions, let viewType):
                buildDiffusionInfoView(header: title, categoryMode: viewType, diffusions: diffusions)
        }
    }
    
    @ViewBuilder
    func buildDiffusionInfoView(header: String, categoryMode: CategoryViewType, diffusions: Diffusions) -> some View {
        VStack (alignment: .leading) {
            Text(header)
                .font(.headline)
                .bold()
                .padding(.horizontal)
            
            LazyVStack {
                ForEach(diffusions) { show in
                    switch categoryMode {
                        case .miniatureCard:
                            MiniatureCardView(viewMode: .color(.random()), text: .constant(show.title ?? "N/A"))
                        case .verticalCard:
                            VerticalCardView(viewMode: .color(.random()),
                                             title: .constant(show.title!),
                                             subtitle: .constant(""))
                        case .fullwidthCard:
                            FullWidthCard(viewMode: .color(.random()), title: .constant(show.title ?? ""), subtitle: .constant(show.standFirst ?? ""))
                    }
                }
            }
            .padding(.horizontal)
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

struct DetailsShowCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsShowCategoryView(type: .info(title: "title", content: "content"))
    }
}
