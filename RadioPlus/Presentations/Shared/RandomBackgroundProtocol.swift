//
//  RandomBackgroundProtocol.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation
import SwiftUI

enum ViewMode {
    case randomImage
    case randomColor
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
            case .randomImage:
                Rectangle()
                    .fill(Color.random())
            case .randomColor:
                Rectangle()
                    .fill(Color.random())
        }
    }
}
