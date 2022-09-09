//
//  BrowserView.swift
//  Pods
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit
import WebKit

public class BrowserView: UIView {
    
    public var marksLayerView: MarksLayerView?
    public var browser: WKWebView?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        browser = WKWebView(frame: self.frame)
        self.addSubview(browser!)
        marksLayerView = MarksLayerView(frame: self.frame)
        self.addSubview(marksLayerView!)
        marksLayerView?.webView = browser!
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    
    
}
