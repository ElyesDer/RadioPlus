//
//  StickyHeaderContainer.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 20/12/2022.
//

import SwiftUI

struct StickyHeaderContainer<Content: View>: View, RandomBackgroundProtocol {
    
    var viewMode: ViewMode
    var minHeight: CGFloat
    var content: Content
    
    init(viewMode: ViewMode = .randomColor, minHeight: CGFloat = 200, @ViewBuilder content: () -> Content) {
        self.viewMode = viewMode
        self.minHeight = minHeight
        self.content = content()
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { geo in
                if(geo.frame(in: .global).minY <= 0) {
                    background
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                } else {
                    background
                        .offset(y: -geo.frame(in: .global).minY)
                        .frame(width: geo.size.width, height: geo.size.height + geo.frame(in: .global).minY)
                }
            }.frame(minHeight: minHeight)
            
            content
        }
    }
}

struct StickyHeaderContainer_Previews: PreviewProvider {
    static var previews: some View {
        StickyHeaderContainer(viewMode: .randomColor) {
            VStack {
                Text("bro")
            }
            .background(Color.red)
        }
    }
}
