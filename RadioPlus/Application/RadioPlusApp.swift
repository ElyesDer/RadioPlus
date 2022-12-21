//
//  RadioPlusApp.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 19/12/2022.
//

import SwiftUI

@main
struct RadioPlusApp: App {
    
    var viewModelFactory: ViewModelFactory = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModelFactory)
                .environmentObject(PlayerManager())
        }
    }
}
