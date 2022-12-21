//
//  Color+.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import Foundation
import SwiftUI

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension Color {
    static func random() -> Color {
        return .init(UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        ))
    }
}

extension String {
    static func randomImageName() -> String {
        "im_cover_\(Int.random(in: 1...21))"
    }
}
