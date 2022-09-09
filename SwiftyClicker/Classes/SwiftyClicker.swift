//
//  SwiftyClicker.swift
//  Pods
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit

public class SwiftyClicker {
    
    var state: SwiftyClickerState = .busy
    var browser: BrowserView?
    
    public init() {
        
    }
    
    public func getSwifytClickerView(frame: CGRect) -> BrowserView? {
        browser = BrowserView(frame: frame)
        return browser
    }
    
    public func setupSwiftyClicker(settings: SwiftyClickerSettings) {
        Statics.settings = settings
        state = .ready
        browser?.marksLayerView?.updateMarksViews()
    }
    
    public func updateMarks(numberOfMark: Int) {
        Statics.settings?.updateNumberOfMark(numberOfMark: numberOfMark)
        browser?.marksLayerView?.updateMarksViews()
    }
    
    public func updateType(type: SwiftyClickerSettingsType) {
        Statics.settings?.updateType(type: type)
        if type == .refresher || type == .scroller {
            Statics.settings?.numberOfMark = 0
            browser?.marksLayerView?.updateMarksViews()
        }
    }
    
    public func load(url: String) {
        browser?.browser?.openURL(urlString: url)
    }
    
    public func getClickerState() -> SwiftyClickerState {
        return state
    }
    
    public func startClicker(completion: @escaping (_ err: Bool, _ response: String) -> ()) {
        
        if state == .ready {
            state = .working
            browser?.marksLayerView?.markViews.forEach { markView in
                let point = ClickerPoint(positionX: Int(markView.center.x), positionY: Int(markView.center.y))
                browser?.browser?.clickPoint(to: point)
            }
            state = .ready
            completion(false,"Clicked with successfully")
            return
        }
        
        completion(true,"Something wrong. Please try again")
        return
        
        
    }
    
    public func startScroller(px: Int, completion: @escaping (_ err: Bool, _ response: String) -> ()) {

        
        if state == .ready {
            state = .working
            let point = ClickerPoint(positionX: 0, positionY: px)
            browser?.browser?.scrollPoint(to: point)
            state = .ready
            completion(false,"Scrolled with successfully")
            return
        }

        completion(true,"Something wrong. Please try again")
        return
    }
    
    public func startRefresher(completion: @escaping (_ err: Bool, _ response: String) -> ()) {
        
        
        if state == .ready {
            state = .working
            browser?.browser?.reload()
            state = .ready
            completion(false,"Reloaded with successfully")
            return
        }

        completion(true,"Something wrong. Please try again")
        return
    }
    
    public func goBack() {
        browser?.browser?.goBack()
    }
    
    public func goForward() {
        browser?.browser?.goForward()
    }
    
    public func reload() {
        browser?.browser?.reload()
    }
    
}
