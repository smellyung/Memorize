import Foundation

// Model
// CardContent is dont care type
// is decided when creating instance of MemoryGame
struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            // find all card indices where isFaceUp = true
            // if there's only 1 card that means its the only face up card
                // else it is either indices of already matched cards
                // or it is empty
            return cards.indices.filter { cards[$0].isFaceUp }.only
        }

        set {
            // set corresponding card with index isFaceUp prop to true
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }

    mutating func choose(card: Card) {
        print("card chosen: \(card)")

        // if you can find the index of the card, it isnt face up nor matched then ..
        if let chosenIndex: Int = cards.firstIndex(matching: card),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {

            // check if it matches the other face up card (if it exist)
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {

                // check if content matches, if so set the cards isMatched props
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                // else no matches so chosen card is the only face up card
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2 + 1, content: content))
        }
        // shuffle cards?
    }

    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
