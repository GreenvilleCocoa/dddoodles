//
//  DDHangingPhotoLayout.swift
//  Doodles
//
//  Created by Ryan Poolos on 5/12/15.
//
//

import UIKit

class DDHangingPhotoLayout: UICollectionViewLayout {
    
    private let decorationStringKind = "decorationStringKind"
    
    private var attributes: [UICollectionViewLayoutAttributes] = []
    private var itemAttributes: [UICollectionViewLayoutAttributes] = []
    
    var interItemSpacing = CGFloat(16.0)
    var itemsPerColumn = CGFloat(3.0)
    
    private var collectionHeight: CGFloat {
        return collectionView?.frame.height ?? 0.0
    }
    
    private var itemHeight: CGFloat {
        return collectionHeight / (itemsPerColumn + 1)
    }
    
    private var itemWidth: CGFloat {
        return CGFloat(100.0)
    }
    
    override init() {
        super.init()
        
        registerClass(DDHangingPhotoStringView.self, forDecorationViewOfKind: decorationStringKind)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
   
    override func prepareLayout() {
        let numberOfSections = collectionView?.numberOfSections()
        
        for var section = 0; section < numberOfSections; section++ {
            let numberOfItems = collectionView?.numberOfItemsInSection(section)
            
            for var item = 0; item < numberOfItems; item++ {
                let indexPath = NSIndexPath(forItem: item, inSection: section)
                
                let itemAttribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                let decorationAttribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: decorationStringKind, withIndexPath: indexPath)
                
                let itemStartX = floor(CGFloat(item) / itemsPerColumn) * (itemWidth + interItemSpacing)
                let itemStartY = floor(CGFloat(item) % itemsPerColumn) * (itemHeight + interItemSpacing)
                
                itemAttribute.frame = CGRect(x: itemStartX, y: itemStartY, width: itemWidth, height: itemHeight)
                
                let decorationStartY = CGRectGetMidY(itemAttribute.frame) - collectionHeight
                
                decorationAttribute.frame = CGRect(x: CGRectGetMidX(itemAttribute.frame), y: decorationStartY, width: 2.0, height: collectionHeight)
                
                
                attributes.append(itemAttribute)
                itemAttributes.append(itemAttribute)
//                attributes.append(decorationAttribute)
            }
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        // Return only visible attributes
        return attributes.filter({ attribute -> Bool in
            return CGRectContainsRect(rect, attribute.frame) || CGRectIntersectsRect(rect, attribute.frame)
        })
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: CGFloat(itemAttributes.count / 3) * itemWidth, height: collectionHeight)
    }
}


private class DDHangingPhotoStringView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.brownColor()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}