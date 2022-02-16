//
//  GameState.swift
//  SwiftUIPlayingCards
//
//  Created by Chris Mash on 15/02/2022.
//

import Foundation

// A representation of a playing card
struct Card: Identifiable, Equatable {
    let id = UUID()
    let number: Int
}

// A representation of a player's hand of cards
class Hand: ObservableObject, Identifiable {
    let id = UUID()
    @Published var cards = [Card]()
}

// A representation of the current state of the game,
// including which cards each player has and the deck
// of cards that can be picked up from
class GameState {
    
    private(set) var deck = Hand()
    private(set) var hands = [Hand]()
    
    init() {
        // Fill the deck with 20 cards, shuffled
        for i in 1...20 {
            deck.cards.append(Card(number: i))
        }
        deck.cards.shuffle()
        
        // Setup two hands of cards with one card each from the deck
        for _ in 0..<2 {
            let hand = Hand()
            for _ in 0..<1 {
                guard let card = deck.cards.popLast() else {
                    fatalError("Tried to deal more cards than in the deck")
                }
                
                hand.cards.append(card)
            }
            
            hands.append(hand)
        }
    }
    
}
