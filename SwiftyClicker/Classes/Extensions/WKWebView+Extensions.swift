//
//  WKWebView+Extensions.swift
//  Pods
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit
import WebKit

extension WKWebView {
    public func clickPoint(to point: ClickerPoint) {
        self.evaluateJavaScript(
            Statics.clickCode + """
                \n
                simulate(document.elementFromPoint(\(point.positionX), \(point.positionY)), \"mouseover\" , { pointerX: \(point.positionX), pointerY: \(point.positionY) } );
                simulate(document.elementFromPoint(\(point.positionX), \(point.positionY)), \"mouseenter\", { pointerX: \(point.positionX), pointerY: \(point.positionY) } );
                simulate(document.elementFromPoint(\(point.positionX), \(point.positionY)), \"mousemove\" , { pointerX: \(point.positionX), pointerY: \(point.positionY) } );
                simulate(document.elementFromPoint(\(point.positionX), \(point.positionY)), \"mousedown\" , { pointerX: \(point.positionX), pointerY: \(point.positionY) } );
                simulate(document.elementFromPoint(\(point.positionX), \(point.positionY)), \"mouseup\"   , { pointerX: \(point.positionX), pointerY: \(point.positionY) } );
                simulate(document.elementFromPoint(\(point.positionX), \(point.positionY)), \"click\"     , { pointerX: \(point.positionX), pointerY: \(point.positionY) } );
                """
        ) { value , error in
            print("Click: (\(point.positionX), \(point.positionY))")
            if let error = error {
                print(error)
            }
        }
    }
    
    public func scrollPoint(to point: ClickerPoint) {
        self.evaluateJavaScript(
            "window.scrollBy({ top: \(point.positionY), left: \(point.positionX), behavior: 'smooth' })"
        ) { value , error in
            print("Scroll: (\(point.positionX), \(point.positionY))")
            if let error = error {
                print(error)
            }
        }
    }
    
    public func openURL(urlString: String) {
        if var url = URL(string: urlString) {
            if url.scheme == nil {
                url = URL(string: "https://" + urlString)!
            }
            
            if UIApplication.shared.canOpenURL(url) && isURLValid(urlString: url.absoluteString) {
                let urlRequest = URLRequest(url: url)
                self.load(urlRequest)
                return
            }
        }
        
        let scheme = "https"
        let host = "www.google.com"
        let path = "/search"
        let queryItem = URLQueryItem(name: "q", value: urlString)
        
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [queryItem]
        
        if let url = urlComponents.url {
            let urlRequest = URLRequest(url: url)
            self.load(urlRequest)
        }
    }
    
    fileprivate func isURLValid(urlString: String) -> Bool {
        let regex = "((http|https|ftp)://)?((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: urlString)
    }
}

