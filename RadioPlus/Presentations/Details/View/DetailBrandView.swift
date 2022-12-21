//
//  BrandDetailView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import SwiftUI

struct DetailBrandView: View {
    
    @EnvironmentObject var player: PlayerManager
    @StateObject var viewModel: DetailsBrandViewModel
    
    var body: some View {
        StickyHeaderContainer {
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Spacer()
                        
                        if let currentlyPlaying = player.currentlyPlaying, currentlyPlaying == viewModel.brand.id {
                            Image(systemName: "pause.circle.fill")
                                .resizable()
                                .frame(width: 45, height: 45, alignment: .center)
                                .padding()
                                .onTapGesture {
                                    player.stop()
                                }
                        } else if let stream = viewModel.liveStream {
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .frame(width: 45, height: 45, alignment: .center)
                                    .padding()
                                    .onTapGesture {
                                        _ = player.play(identifier: viewModel.brand.id ?? "", url: stream)
                                    }
                            }
                    }
                    MiniatureCardView(viewMode: .color(.random()), text: $viewModel.title)
            }
            
            Spacer()
            
            VStack(alignment:.leading, spacing: 15) {
                AnyView(render())
            }.frame( minWidth: 0,
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

extension DetailBrandView {
    func render() -> any View {
        Group {
            ForEach(viewModel.renderedContent) { view in
                view
            }
        }
    }
}

struct DetailBrandView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModelFactory: ViewModelFactory = .init()
        DetailBrandView(viewModel: viewModelFactory.buildBrandViewModel(brand: .init(id: "id", title: "Brand title", baseline: "brand baseline", brandDescription: " big brand description", websiteURL: "Brand url", liveStream: "brand live stream", localRadios: [.init(id: "id", title: "Radio title", radioDescription: "Radio description", liveStream: ""), .init(id: "id2", title: "Radio @", radioDescription: "Radio description", liveStream: ""), .init(id: "id4", title: "Radio @3", radioDescription: "Radio description", liveStream: "")], webRadios: [.init(id: "id4", title: "Radio @3", radioDescription: "Radio description", liveStream: "")])))
    }
}

