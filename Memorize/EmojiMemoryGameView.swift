import SwiftUI

// View
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        // can add spacing but leave for standard padding
        // HStack(spacing:content:)
        Grid(items: viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(6)
        }
        .padding()
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader(content: { geometry in
            body(for: geometry.size)
        })
    }

    @ViewBuilder // body() return type is interpreted as a list of Views
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(
                    startAngle: Angle.degrees(0 - 90),
                    endAngle: Angle.degrees(110 - 90),
                    clockWise: true
                )
                .padding(5)
                .opacity(0.4)
                Text(card.content)
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
        .font(Font.system(size: fontSize(for: size)))
    }

    // MARK: - Drawing Constants
    private let fontScaleFactor: CGFloat = 0.7

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

// compile code and run in preview
// see changes in real time
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
