//
//  FullWidthCard.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import SwiftUI

struct FullWidthCard: View, RandomBackgroundProtocol {
    
    var viewMode: ViewMode
    @Binding var title: String
    @Binding var subtitle: String
    
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            
            background
            
            VStack(alignment: .leading) {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text(subtitle)
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            .padding()
        }
        .cornerRadius(5)
        .frame(height: 180)
    }
}

struct FullWidthCard_Previews: PreviewProvider {
    static var previews: some View {
        FullWidthCard(viewMode: .color(.random()), title: .constant("Sub head line Sub head line"), subtitle: .constant("Sub head line Sub head line Sub head line Sub head line Sub head line Sub head line Sub head line Sub head line"))
    }
}
