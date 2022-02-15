//
//  CardView.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import SwiftUI

// A view to represent a single card
struct CardView: View {
    
    let card: Card
    let namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20,
                             style: .continuous)
                .fill(Color.white)
            RoundedRectangle(cornerRadius: 20,
                             style: .continuous)
                .stroke(.black, lineWidth: 2)
                
            Text("\(card.number)")
        }
        .frame(width: 60, height: 80)
        .matchedGeometryEffect(id: "\(card.number)",
                               in: namespace)
        .transition(.scale(scale: 1))
    }
    
}

struct CardView_Previews: PreviewProvider {
    // Create a wrapper view that will let us hold a @Namespace to pass to the view
    struct Wrapper: View {
        @Namespace var animation
        var body: some View {
            CardView(card: Card(number: 1), namespace: animation)
                .padding()
                .background(Color.gray)
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
