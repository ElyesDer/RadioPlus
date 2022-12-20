//
//  HomeView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                AnyView(render())
            }
            .onAppear {
                viewModel.prepareHome()
            }
            .tabItem {
                Label(title: {
                    Text("Home")
                }, icon: {
                    Image(systemName: "pencil.circle.fill")
                })
            }
        }
    }
}

extension HomeView {
    func render() -> any View {
        Group {
            ForEach(viewModel.content) { view in
                view
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModelFactory: ViewModelFactory = .init()
        
        HomeView(viewModel: viewModelFactory.buildHomeViewModel())
    }
}
