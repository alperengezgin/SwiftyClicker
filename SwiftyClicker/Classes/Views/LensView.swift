//
//  LensView.swift
//  Pods
//
//  Created by Alperen Polat Gezgin on 6.09.2022.
//

import UIKit

class LensView: UIView {
    
    @IBOutlet weak var zoomedView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = self.loadViewFromNib(nibName: "LensView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
        imageView.image = Statics.settings?.lensImage ?? Resources.shared.getDefaultImage(for: .defaultLens)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.roundCorners(radius: bounds.size.height / 2)
    }
    
}
