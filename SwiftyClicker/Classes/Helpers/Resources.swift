//
//  Resources.swift
//  Pods
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit

public class Resources {
    
    public static let shared = Resources()
    
    private init() {
        
    }
    
    public func getDefaultImage(for image: Images) -> UIImage {
        return UIImage(named: image.rawValue, in: getBundle(), with: .none)!
    }
    
    public func getBundle() -> Bundle {
        return Bundle(for: SwiftyClicker.self)
    }
}



public enum Images: String {
    case defaultLens = "lens"
    case defaultMark = "mark"
}
