//
//  ViewController.swift
//  SwiftyClicker
//
//  Created by Alperen Polat GEZGIN on 09/06/2022.
//  Copyright (c) 2022 Alperen Polat GEZGIN. All rights reserved.
//

import UIKit
import SwiftyClicker

class ViewController: UIViewController {
    
    var browser: BrowserView?
    var current = 1
    var swiftyClicker: SwiftyClicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        swiftyClicker = SwiftyClicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        browser = swiftyClicker.getSwifytClickerView(frame: self.view.frame)
        self.view.addSubview(browser!)
        swiftyClicker.setupSwiftyClicker(settings: SwiftyClickerSettings(type: .scroller))
        swiftyClicker.load(url: "alperen")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.swiftyClicker.startScroller(px: 300) { err, response in
                
            }
            self.swiftyClicker.updateMarks(numberOfMark: 1)
            self.swiftyClicker.startClicker { err, response in
                
            }
            self.swiftyClicker.startRefresher { err, response in
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

