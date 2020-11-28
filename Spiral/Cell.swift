import Foundation

// Class which help to find right symbol in line
final class Cell {
    
    private static let fillSymbol = "*"
    private static let emptySymbol = " "
    
    var symbol: String {
        return isFilled ? Cell.fillSymbol : Cell.emptySymbol
    }
    
    let x: Int
    let y: Int
    
    var isFilled = false
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
