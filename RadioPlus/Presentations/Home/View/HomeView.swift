//
//  HomeView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import SwiftUI

protocol HomeCategoryProtocol {
    
    associatedtype Content: View
    var content: Content { get }
    
    func fetchDataOnAppear<T>() async throws -> T where T: Codable
}

//enum HomeCategoryView: HomeCategoryProtocol {
//
//    typealias Content = View
//
//    func fetchDataOnAppear<T>() async throws -> T where T : Decodable, T : Encodable {
//
//    }
//
//    case podcast
//    case brands
//    case alaffiche
//    case youmaylike
//    case latest
//
//    func getView() -> some View {
//        Text("Bro")
//    }
//
//}

struct BrandsView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center) {
                ForEach(1...100, id: \.self) {
                    Text("Row \($0)")
                }
            }
        }
    }
}


struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                BrandsView()
            }
            .tabItem {
                Label(title: {
                    Text("Bro")
                }, icon: {
                    Image(systemName: "pencil.circle.fill")
                })
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
