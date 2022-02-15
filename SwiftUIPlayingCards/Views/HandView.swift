//
//  HandView.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import SwiftUI

// A view to represent the cards in a hand
struct HandView: View {
    
    let hand: Hand
    let namespace: Namespace.ID
    let onCardTap: (Card) -> Void
    
    var body: some View {
        HStack {
            ForEach(hand.cards) { card in
                CardView(card: card, namespace: namespace)
                    .onTapGesture {
                        onCardTap(card)
                    }
            }
        }
    }
    
}

struct HandView_Previews: PreviewProvider {
    // Create a wrapper view that will let us hold a @Namespace to pass to the view
    struct Wrapper: View {
        @Namespace var namespace
        
        var hand: Hand {
            let hand = Hand()
            hand.cards.append(contentsOf: [
                Card(number: 1),
                Card(number: 2)
            ])
            return hand
        }
        
        var body: some View {
            HandView(hand: hand,
                     namespace: namespace) { _ in }
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
