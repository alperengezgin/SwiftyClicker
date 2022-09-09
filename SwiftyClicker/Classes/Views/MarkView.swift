//
//  MarkView.swift
//  Pods
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit

protocol MarkViewDelegate {
    func touchesBegan(markView: MarkView)
    func touchesEnded(markView: MarkView)
    func touchMove(markView: MarkView)
}

class MarkView: UIView {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: MarkViewDelegate?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = self.loadViewFromNib(nibName: "MarkView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        
        blurView.backgroundColor = .white
        blurView.roundCorners(radius: blurView.bounds.size.height / 2)
        blurView.alpha = 0.3
        imageView.image = Statics.settings?.markImage ?? Resources.shared.getDefaultImage(for: .defaultMark)
        
        let movePanGesture = UIPanGestureRecognizer(target: self, action: #selector(movePanGesture(_:)))
        movePanGesture.minimumNumberOfTouches = 1
        movePanGesture.maximumNumberOfTouches = 1
        addGestureRecognizer(movePanGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurView.roundCorners(radius: blurView.bounds.size.height / 2)
    }
    
    @objc func movePanGesture(_ sender: UIPanGestureRecognizer) {
        guard let superview = superview else { return }
        
        switch sender.state {
        case .began, .changed:
            let location = sender.location(in: superview)
            center = location
            delegate?.touchMove(markView: self)
            
        default:
            checkCenterInSuperView()
            delegate?.touchesEnded(markView: self)
            break
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.touchesBegan(markView: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        checkCenterInSuperView()
        delegate?.touchesEnded(markView: self)
    }
    
    func checkCenterInSuperView() {
        guard let superview = superview else { return }
        
        if superview.bounds.contains(center) == false {
            
            var centerX = center.x
            var centerY = center.y
            
            if centerX > superview.bounds.maxX { centerX = superview.bounds.maxX - 3 }
            if centerX < superview.bounds.minX { centerX = superview.bounds.minX + 3 }
            
            if centerY > superview.bounds.maxY { centerY = superview.bounds.maxY - 3 }
            if centerY < superview.bounds.minY { centerY = superview.bounds.minY + 3 }
            
            UIView.animate(withDuration: 0.1) {
                self.center = CGPoint(x: centerX, y: centerY)
            }
            
        }
    }
}
