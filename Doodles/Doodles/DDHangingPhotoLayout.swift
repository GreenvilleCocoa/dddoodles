//
//  DDHangingPhotoLayout.swift
//  Doodles
//
//  Created by Ryan Poolos on 5/12/15.
//
//

import UIKit

class DDHangingPhotoLayout: UICollectionViewLayout {
    
    // =========================================================================
    // MARK: - Public Properties
    // =========================================================================
    
    var minimumItemSize = CGSize(width: 100, height: 100)
    var maximumItemSize = CGSize(width: 200, height: 200)
    
    var minimumInterItemSpacing = CGFloat(16.0)
    
    var sectionInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    
    var itemsPerColumn: CGFloat {
        return (collectionHeight - (sectionInsets.top + sectionInsets.bottom)) / (maximumItemSize.height + minimumInterItemSpacing)
    }
    
    // =========================================================================
    // MARK: - Private Properties
    // =========================================================================
    
    private let DDDecorationStringKind = "DDDecorationStringKind"
    
    private var attributes: [UICollectionViewLayoutAttributes] = []
    private var itemAttributes: [UICollectionViewLayoutAttributes] {
        return attributes.filter { (attribute: UICollectionViewLayoutAttributes) -> Bool in
            return attribute.representedElementCategory == .Cell
        }
    }
    
    private var collectionHeight: CGFloat {
        return collectionView?.frame.height ?? 0.0
    }
    
    // =========================================================================
    // MARK: - Lifecycle
    // =========================================================================
    
    override init() {
        super.init()
        
        registerClass(DDHangingPhotoStringView.self, forDecorationViewOfKind: DDDecorationStringKind)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // =========================================================================
    // MARK: - UICollectionViewLayout
    // =========================================================================
    
    override func invalidateLayout() {
        super.invalidateLayout()
        
        attributes = []
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        if let originalBounds = collectionView?.bounds {
            return originalBounds == newBounds
        }
        
        return false
    }
    
    override func prepareLayout() {
        let numberOfSections = collectionView?.numberOfSections()
        
        for var section = 0; section < numberOfSections; section++ {
            let numberOfItems = collectionView?.numberOfItemsInSection(section)
            
            for var item = 0; item < numberOfItems; item++ {
                let indexPath = NSIndexPath(forItem: item, inSection: section)
                
                let itemAttribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                let decorationAttribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: DDDecorationStringKind, withIndexPath: indexPath)
                
                let itemStartX = floor(CGFloat(item) / itemsPerColumn) * (maximumItemSize.width + minimumInterItemSpacing) + sectionInsets.left
                let itemStartY = floor(CGFloat(item) % itemsPerColumn) * (maximumItemSize.height + minimumInterItemSpacing) + sectionInsets.top
                
                itemAttribute.frame = CGRect(origin: CGPoint(x: itemStartX, y: itemStartY), size: randomItemSize())
                itemAttribute.zIndex = 1000
                itemAttribute.transform = CGAffineTransformMakeRotation(randomAngle())
                
                
                // Create Decoration Attributes
                let decorationStartY = CGRectGetMidY(itemAttribute.frame) - collectionHeight
                
                decorationAttribute.frame = CGRect(x: CGRectGetMidX(itemAttribute.frame), y: decorationStartY, width: 2.0, height: collectionHeight)
                decorationAttribute.zIndex = 0
                
                attributes.append(itemAttribute)
                attributes.append(decorationAttribute)
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
        let sectionInsetsAdjustment = sectionInsets.left + sectionInsets.right
        let fullItemWidth = maximumItemSize.height + minimumInterItemSpacing;
        
        return CGSize(width: ceil(CGFloat(itemAttributes.count) / itemsPerColumn) * fullItemWidth + sectionInsetsAdjustment, height: collectionHeight)
    }
    
    // =========================================================================
    // MARK: - Convenience
    // =========================================================================
    
    func randomAngle() -> CGFloat {
        let multiplier = (arc4random() % 2) == 0 ? CGFloat(-1.0) : CGFloat(1.0)
        let angle = CGFloat(arc4random_uniform(30)) / 360.0
        return multiplier * angle
    }
    
    func randomItemSize() -> CGSize {
        let width = minimumItemSize.width + CGFloat(arc4random_uniform(UInt32(maximumItemSize.width - minimumItemSize.width)))
        //        let height = minimumItemSize.height + CGFloat(arc4random_uniform(UInt32(maximumItemSize.height - minimumItemSize.height)))
        let height = maximumItemSize.height * (width / maximumItemSize.width)
        
        return CGSize(width: width, height: height)
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