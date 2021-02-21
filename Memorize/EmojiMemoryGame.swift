import Foundation
//import SwiftUI

// viewModel
class EmojiMemoryGame: ObservableObject {
    // store model
    @Published private var game: MemoryGame<String> = createMemoryGame()

    // function on the type itself not instance
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🧙‍♀️", "😸"]
        return MemoryGame(numberOfPairsOfCards: emojis.count) { pairIndex in emojis[pairIndex] }
    }

    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        game.cards
    }

    // MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }

}
