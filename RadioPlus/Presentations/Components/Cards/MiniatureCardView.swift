//
//  MiniatureCardView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import SwiftUI

struct MiniatureCardView: View, RandomBackgroundProtocol {
    
    var viewMode: ViewMode
    @Binding var text: String
    
    var body: some View {
        ZStack {
            background
            
            Text(text)
                .foregroundColor(.white)
                .font(.headline)
                .padding()
        }
        .cornerRadius(10)
        .frame(width: 150, height: 100, alignment: .center)
    }
}

struct MiniatureCardView_Previews: PreviewProvider {
    static var previews: some View {
        MiniatureCardView(viewMode: .color(.random()), text: .constant("Radio Name"))
    }
}
