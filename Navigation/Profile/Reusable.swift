import UIKit

// Setup reusable protocol
protocol ReusableView: AnyObject {
    static var identifier : String { get }
}

// Add it to collection view cell 
extension UICollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
