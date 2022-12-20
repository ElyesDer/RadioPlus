//
//  RandomBackgroundProtocol.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation
import SwiftUI

enum ViewMode {
    case image(String)
    case color(Color)
}

protocol RandomBackgroundProtocol {
    
    associatedtype Background: View
    var background: Background { get }
    
    var viewMode: ViewMode { get }
    
}

extension RandomBackgroundProtocol {
    
    @ViewBuilder
    var background: some View {
        switch viewMode {
            case .image(let imageName):
                Rectangle()
                    .fill(Color.random())
            case .color(let color):
                Rectangle()
                    .fill(color)
        }
    }
}
