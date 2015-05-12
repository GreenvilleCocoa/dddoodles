//
//  DoodleCollectionViewCell.swift
//  Doodles
//
//  Created by Marcus Smith on 5/12/15.
//
//

import UIKit

class DoodleCollectionViewCell: UICollectionViewCell {
    var frameImageView: UIImageView
    var doodleImageView: UIImageView
    
    override init(frame: CGRect) {
        self.frameImageView = UIImageView(image: UIImage(named: "frame"))
        self.frameImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.doodleImageView = UIImageView()
        self.doodleImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.doodleImageView.backgroundColor = UIColor.blueColor()
        
        super.init(frame: frame)
        
        self.contentView.addSubview(self.doodleImageView)
        self.contentView.addSubview(self.frameImageView)
        
        let views: [NSObject: AnyObject] = ["frame": frameImageView,
                                            "doodle": doodleImageView,
                                            ]
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[frame]|", options: nil, metrics: nil, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[frame]|", options: nil, metrics: nil, views: views))
        NSLayoutConstraint(item: self.doodleImageView, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: self.doodleImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0).active = true
        NSLayoutConstraint(item: self.doodleImageView, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 0.90, constant: 0.0).active = true
        NSLayoutConstraint(item: self.doodleImageView, attribute: .Height, relatedBy: .Equal, toItem: self.contentView, attribute: .Height, multiplier: 0.90, constant: 0.0).active = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
