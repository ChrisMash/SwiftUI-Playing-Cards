//
//  DeckView.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 16/02/2022.
//

import SwiftUI

struct DeckView: View {
    
    @ObservedObject var deck: Hand
    let namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            // Just need to draw the last two so that the transition of card
            // from the hand back to the deck results in the old top card being
            // rendered as the new top card animates in
            ForEach(deck.cards.suffix(2)) {
                CardView(card: $0, namespace: namespace)
            }
        }
    }
}

struct DeckView_Previews: PreviewProvider {
    // Create a wrapper view that will let us hold a @Namespace to pass to the view
    struct Wrapper: View {
        @Namespace var namespace
        
        var deck: Hand {
            let deck = Hand()
            deck.cards.append(contentsOf: [
                Card(number: 1),
                Card(number: 2)
            ])
            return deck
        }
        
        var body: some View {
            DeckView(deck: deck,
                     namespace: namespace)
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
