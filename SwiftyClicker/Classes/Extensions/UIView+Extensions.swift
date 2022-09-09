//
//  UIView+Extensions.swift
//  Pods-SwiftyClicker_Example
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit

extension UIView {
    
    public func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Resources.shared.getBundle()
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
    
    public func roundCorners(
        radius: CGFloat,
        corners: CACornerMask = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    ) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
}
