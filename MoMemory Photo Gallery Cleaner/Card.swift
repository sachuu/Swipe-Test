//  Thank you to Franck Mpouli
//  for the card structure
//

import UIKit
import Photos

//MARK: - DATA
struct Card: Identifiable {
    let id = UUID()
    let imageName: String
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0
    
    static var data: [Card] {
        [
            Card(imageName: "p0"),
        ]
    }
    
}
