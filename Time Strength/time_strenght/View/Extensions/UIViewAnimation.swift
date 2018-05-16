//
//  UIViewAnimation.swift


import UIKit

extension UIView {
    
    class func animateToTop(element: UIImageView, y: CGFloat, elementLayout: NSLayoutConstraint) {
        elementLayout.constant = y
        UIView.animate(withDuration: 0.2) {
            element.layoutIfNeeded()
        }
    }
    class func animateToScreenEnd(element: UIImageView, elementLayout: NSLayoutConstraint, newPos: CGFloat ) {
        elementLayout.constant = newPos
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
         element.layoutIfNeeded()
         }, completion: nil)
    }
    
    
}
