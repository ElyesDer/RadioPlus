//
//  ContentView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var factory: ViewModelFactory
    var body: some View {
        NavigationView {
            TabView {
                HomeView(viewModel: factory.buildHomeViewModel())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
