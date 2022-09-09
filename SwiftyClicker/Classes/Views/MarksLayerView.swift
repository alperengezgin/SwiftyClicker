//
//  MarksLayerView.swift
//  Pods
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit
import WebKit

public class MarksLayerView: UIView {
    
    var markViews = [MarkView]()
    var webView: WKWebView?
    
    lazy var lensView: LensView = {
        let lensView = LensView(frame: CGRect(x: 0, y: 0, width: 65, height: 65))
        lensView.isHidden = true
        lensView.alpha = 0.0
        return lensView
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    func commonInit() {
        backgroundColor = .clear
        lensView.center = center
        addSubview(lensView)
        updateMarksViews()
    }
    
    func updateMarksViews() {
        let marksDefaultPositions: [CGPoint] = [
            CGPoint(x: center.x, y: center.y),
            CGPoint(x: center.x, y: center.y + 150),
            CGPoint(x: center.x, y: center.y - 150),
            CGPoint(x: center.x + 150, y: center.y),
            CGPoint(x: center.x - 150, y: center.y)
        ]
        
        let numberOfMark = Statics.settings?.numberOfMark ?? 0
        
        while markViews.count < numberOfMark {
            let index = markViews.count
            
            let markView = MarkView()
            markView.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
            markView.center = marksDefaultPositions[index]
            markView.delegate = self
            addSubview(markView)
            markViews.append(markView)
        }
        
        while markViews.count > numberOfMark {
            if let lastMarkView = markViews.last {
                lastMarkView.removeFromSuperview()
                markViews.removeLast()
            }
        }
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    func drawLens(markView: MarkView) {
        guard let webView = webView else { return }
        let scale = CGFloat(2)
        
        let workingSize = markView.imageView.bounds.size
        let workingCenter = markView.center
        
        UIGraphicsBeginImageContextWithOptions(workingSize , false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        context.translateBy(x: workingSize.width/2, y: workingSize.height/2)
        context.scaleBy(x: scale, y: scale)
        context.translateBy(
            x: -workingCenter.x,
            y: -workingCenter.y
        )
        webView.layer.render(in: context)
        lensView.zoomedView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}


extension MarksLayerView: MarkViewDelegate {
    
    func touchesBegan(markView: MarkView) {
        lensView.center = CGPoint(x: markView.center.x, y: markView.center.y - 100)
        drawLens(markView: markView)
        
        if lensView.isHidden {
            lensView.alpha = 0
            lensView.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.lensView.alpha = 1
            }
        }
    }
    
    func touchesEnded(markView: MarkView) {
        lensView.center = CGPoint(x: markView.center.x, y: markView.center.y - 100)
        drawLens(markView: markView)
        
        if lensView.isHidden == false {
            UIView.animate(withDuration: 0.1) {
                self.lensView.alpha = 0
            } completion: { (_) in
                self.lensView.isHidden = true
            }
        }
    }
    
    func touchMove(markView: MarkView) {
        drawLens(markView: markView)
        lensView.center = CGPoint(x: markView.center.x, y: markView.center.y - 100)
        
        if lensView.isHidden {
            lensView.alpha = 0
            lensView.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.lensView.alpha = 1
            }
        }
    }
}

