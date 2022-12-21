//
//  DetailsShowView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import SwiftUI

struct DetailsShowView: View {
    
    @StateObject var viewModel: DetailsShowViewModel
    
    var body: some View {
        StickyHeaderContainer {
            VStack {
                VerticalCardView(viewMode: .color(.random()), title: $viewModel.title, subtitle: .constant(""))
                
                Spacer()
                    VStack(alignment: .leading, spacing: 15) {
                        AnyView(render())
                    }
                    .frame( minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .leading )
            }
            .offset(y: -50)
        }
        .onAppear {
            viewModel.prepareView()
        }
    }
}

extension DetailsShowView {
    func render() -> any View {
        Group {
            ForEach(viewModel.renderedContent) { view in
                view
            }
        }
    }
}

struct DetailsShowView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory: ViewModelFactory = .init()
        DetailsShowView(viewModel: viewModelFactory.buildShowViewModel(show: .init(id: "ID", title: "Show title", standFirst: "Stand first text", url: "Url", diffusion: .init(id: "Diffid", title: "Diffusion title", standFirst: "Stand first", url: "url", publishedDate: "", podcastEpisode: nil), diffusionsConnection: nil)))
    }
}

