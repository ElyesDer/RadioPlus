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
            HomeView(viewModel: factory.buildHomeViewModel())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
