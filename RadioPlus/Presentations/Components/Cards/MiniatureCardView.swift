//
//  MiniatureCardView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import SwiftUI

struct MiniatureCardView: View, RandomBackgroundProtocol {
    
    var viewMode: ViewMode
    @Binding var content: String
    
    var body: some View {
        ZStack {
            background
            
            Text(content)
                .foregroundColor(.white)
                .font(.headline)
                .padding()
        }
        .cornerRadius(10)
        .frame(width: 180, height: 100, alignment: .center)
    }
}

struct MiniatureCardView_Previews: PreviewProvider {
    static var previews: some View {
        MiniatureCardView(viewMode: .color(.random()), content: .constant("Radio Name"))
    }
}
