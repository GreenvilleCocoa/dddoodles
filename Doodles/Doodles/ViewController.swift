//
//  ViewController.swift
//  Doodles
//
//  Created by Marcus Smith on 5/12/15.
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        let views = ["collection": collectionView]
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collection]|", options: nil, metrics: nil, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collection]|", options: nil, metrics: nil, views: views))
    }
    
    //==========================================================================
    // Mark: UICollectionView
    //==========================================================================
    
    let cellIdentifier = "DoodleCell"
    
    lazy var layout: DDHangingPhotoLayout = {
        let layout = DDHangingPhotoLayout()
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.layout)
        collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        return collectionView
    }()
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Tapped \(indexPath)")
    }
    
}
