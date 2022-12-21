//
//  HomeView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("LightGray"))
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Local search ..", text: $searchText)
            }
            .foregroundColor(.gray)
            .padding(.leading, 10)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            SearchBar(searchText: $viewModel.searchText)
            VStack(spacing: 15) {
                AnyView(render())
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
            ForEach(viewModel.renderedContent) { view in
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
