//
//  SwiftyClickerSettings.swift
//  Pods
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit

public class SwiftyClickerSettings {
    public var numberOfMark: Int!
    public var lensImage: UIImage!
    public var markImage: UIImage!
    public var type: SwiftyClickerSettingsType!
    
    public init(type: SwiftyClickerSettingsType,numberOfMark: Int? = 0, lensImage: UIImage? = Resources.shared.getDefaultImage(for: .defaultLens), markImage: UIImage? = Resources.shared.getDefaultImage(for: .defaultMark)) {
        self.numberOfMark = numberOfMark
        self.lensImage = lensImage
        self.markImage = markImage
        self.type = type
    }
    
    public func updateNumberOfMark(numberOfMark: Int) {
        self.numberOfMark = numberOfMark
    }
    
    public func updateType(type: SwiftyClickerSettingsType) {
        self.type = type
    }
}

public enum SwiftyClickerSettingsType {
    case clicker
    case scroller
    case refresher
}
