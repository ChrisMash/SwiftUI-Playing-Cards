//
//  ContentView.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var gameState = GameState()
    @Namespace private var animation
    
    var body: some View {
        VStack {
            // Some simple instructions
            Text("""
                Tap a + button to add a card from the deck to the relevant hand.
                Tap a card in a hand to send it back to the deck.
                """)
                .multilineTextAlignment(.center)
            
            // Draw the deck of cards players can pick up from
            ZStack {
                // Just need to draw the last two so that the transition of card
                // from the hand back to the deck results in the old top card being
                // rendered as the new top card animates in
                ForEach(gameState.deck.cards.suffix(2)) {
                    CardView(card: $0, namespace: animation)
                }
            }
            
            // Draw each player's hand of cards
            ForEach(gameState.hands) { hand in
                HStack {
                    // Include a button to pull a card from the deck into this hand
                    Button("+") {
                        addCard(to: hand)
                    }
                    .padding(.leading)
                    
                    HandView(hand: hand,
                             namespace: animation,
                             onCardTap: {
                        remove(card: $0, from: hand)
                    })
                }
            }
        }
    }
    
    // MARK: Private functions
    private func addCard(to hand: Hand) {
        withAnimation {
            guard let card = gameState.deck.cards.popLast() else {
                print("Deck is empty!")
                return
            }
            
            hand.cards.append(card)
        }
    }
    
    private func remove(card: Card, from hand: Hand) {
        withAnimation {
            // Put the card back in the deck
            guard let index = hand.cards.firstIndex(of: card) else {
                fatalError("Failed to find tapped card in hand")
            }
            
            hand.cards.remove(at: index)
            gameState.deck.cards.append(card)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
