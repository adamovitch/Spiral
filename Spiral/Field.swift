import Foundation

// Main class
final class Field {
    
    //Divider to make letters field be equals in width and height
    private static let hightDivider: CGFloat = 2.1
    
    //Size of spiral in letters
    let size: Int
    var isAdvanced = false
    
    var cells = [[Cell]]()
    var cellsDictionary = [MyPoint: Cell]()
    
    init(_ size: Int) {
        self.size = size
        self.cells = initCells()
    }
    
    func printSpiral(isAdvanced: Bool) {
        self.isAdvanced = isAdvanced
        self.setCellsSymbols()
        self.cells.forEach { cellsString in
            var string = ""
            cellsString.forEach { cell in
                string.append(cell.symbol)
            }
            print(string)
        }
    }
    
    //Init cells which will has symbols for print
    private func initCells() -> [[Cell]] {
        let vertical = Int(CGFloat(self.size)/Field.hightDivider)
        var result = [[Cell]]()
        for i in 0..<vertical {
            var cellsString = [Cell]()
            for j in 0..<self.size {
                let cell = Cell(x: j, y: i)
                self.cellsDictionary[MyPoint(x: j, y: i)] = cell
                cellsString.append(cell)
            }
            result.append(cellsString)
        }
        return result
    }
    
    //Set right symbol to Cell
    private func fillCell(_ x: Int, _ y: Int) {
        if let cell = self.cellsDictionary[MyPoint(x: x, y: y)] {
            cell.isFilled = true
        }
    }
    
    private func setCellsSymbols() {
        //Set constant for base and advanced spiral
        let pointsCount = self.isAdvanced ? 800 : 2000
        let constant: CGFloat = 0.4
        let widthConstant: CGFloat = self.isAdvanced ? 1.2 : 0.8
        
        //Calculate field zero points (spiral start point)
        let centerX = CGFloat(self.size/2)
        let centerY = CGFloat(CGFloat(self.size/2)/Field.hightDivider)
        
        //2 variables for check we won't process the same cells twice or more
        var previousXValue = Int.max
        var previousYValue = Int.max
        
        let stepDivider: CGFloat = self.isAdvanced ? 10.0 : 20.0
        
        for i in 0...pointsCount {
            //Less or more control points on virtual spiral
            let iFloat = -CGFloat(i)/stepDivider
            //Calculate virtual spiral points
            let phi = iFloat*constant
            let r = widthConstant*iFloat
            let x = Int(r*cos(phi) + centerX)
            let y = Int((r*sin(phi))/Field.hightDivider + centerY)
            
            // Fill base spiral cell and continue loop
            if !self.isAdvanced {
                fillCell(x, y)
                continue
            }
            
            // Advanced spiral logic below
            
            //Check it's not the same cell
            if previousXValue == x && previousYValue == y {
                continue
            }
            previousXValue = x
            previousYValue = y
            
            // Seе ranges to make spiral a little bit thicker
            let xRange = x-2...x+3
            let yRange = y-1...y+2
            
            for currentX in xRange {
                for currentY in yRange {
                    fillCell(currentX, currentY)
                }
                
            }
        }
    }
}
