import UIKit

@IBDesignable
class NewTaskTextField: UITextField {
    override func draw(_ rect: CGRect) {
        let border = CALayer()
        let borderWidth = CGFloat(0.5)
        
        border.borderColor = UIColor(red: 196/255, green: 196/255, blue: 198/255, alpha: 1).cgColor
        border.frame = CGRect(x: -borderWidth, y: 0, width: frame.size.width + borderWidth * 2, height: frame.size.height)
        border.borderWidth = borderWidth
        
        borderStyle = .none
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.addSublayer(border)
    }
    
    private func getNewBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 20, 0, 20))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return getNewBounds(bounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return getNewBounds(bounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return getNewBounds(bounds: bounds)
    }
}
