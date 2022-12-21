//
//  VerticalCardView.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import SwiftUI

struct VerticalCardView: View, RandomBackgroundProtocol {
    
    var viewMode: ViewMode
    
    @Binding var title: String
    @Binding var subtitle: String
    
    var body: some View {
        ZStack (alignment: .bottom) {
            
            background
            
            VStack(alignment: .leading) {
                Spacer()
                Text(title)
                    .foregroundColor(.random())
                    .bold()
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                
                Text(subtitle)
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            .padding(4)
        }
        .cornerRadius(10)
        .frame(width: 150, height: 200, alignment: .bottom)
    }
}

struct VerticalCardView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalCardView(viewMode: .image(.randomImageName()), title: .constant("head line Sub head line"), subtitle: .constant("Sub head "))
    }
}
