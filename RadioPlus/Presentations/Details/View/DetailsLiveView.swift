//
//  DetailsLiveView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import SwiftUI

struct DetailsLiveView: View {
    
    @StateObject var viewModel: DetailsLiveViewModel
    
    var body: some View {
        StickyHeaderContainer {
            VStack {
                VerticalCardView(viewMode: .color(.random()), title: .constant(viewModel.title ?? ""), subtitle: .constant(""))
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Stand first")
                        .font(.headline)
                    
                    Text(viewModel.standFirst)
                        .font(.body)
                    
                    Spacer()
                    
                    Text("Currently playing")
                        .font(.headline)
                    
                    Text(viewModel.currentlyPlaying)
                        .font(.body)
                }
                .frame( minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .leading )
                .padding()
            }
            .offset(y: -160)
        }
    }
}

struct DetailsLiveView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory: ViewModelFactory = .init()
        DetailsLiveView(viewModel: viewModelFactory.buildLiveViewModel(live: .init(show: .init(id: "id", title: "Live show", standFirst: nil, url: nil, diffusion: .init(id: "id2", title: "Diffusion title", standFirst: "Stadn first diff", url: "url", publishedDate: "Date", podcastEpisode: nil), diffusionsConnection: nil), program: .init(id: "", diffusion: .init(id: "id", title: "Title diffusion", standFirst: "long standfirst text", url: "url", publishedDate: "Date", podcastEpisode: nil)), song: "Current playing song")))
    }
}
