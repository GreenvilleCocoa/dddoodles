//
//  ViewController.swift
//  Doodles
//
//  Created by Marcus Smith on 5/12/15.
//
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var doodleButton: UIButton
    var doodleImageView: UIImageView
    
    var firstnameField: UITextField
    var lastnameField: UITextField
    var doodleNameField: UITextField
    
    init()
    {
        doodleButton = UIButton()
        doodleImageView = UIImageView()
        
        firstnameField = UITextField()
        lastnameField = UITextField()
        doodleNameField = UITextField()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    var data: [Doodle] = []

    required init(coder aDecoder: NSCoder) {
        doodleButton = UIButton()
        doodleImageView = UIImageView()
        
        firstnameField = UITextField()
        lastnameField = UITextField()
        doodleNameField = UITextField()
        
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(self.doodleButton)
        view.addSubview(self.doodleImageView)
        
        view.addSubview(self.firstnameField)
        view.addSubview(self.lastnameField)
        view.addSubview(self.doodleNameField)
        
        self.doodleImageView.hidden = true
        
        self.setupViews()
        
        let views = ["collection": collectionView]
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collection]|", options: nil, metrics: nil, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collection]|", options: nil, metrics: nil, views: views))
        
        self.fetchData()
    }
    
    func setupViews()
    {
        self.firstnameField.delegate = self
        self.lastnameField.delegate = self
        self.doodleNameField.delegate = self
        
        self.doodleButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.doodleButton.setTitle("Doodle", forState: UIControlState.Normal)
        self.doodleButton.backgroundColor = UIColor.greenColor()
        
        self.doodleImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.firstnameField.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.lastnameField.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.doodleNameField.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.firstnameField.backgroundColor = UIColor.grayColor()
        self.lastnameField.backgroundColor = UIColor.grayColor()
        self.doodleNameField.backgroundColor = UIColor.grayColor()
        
        self.firstnameField.placeholder = "First name"
        self.lastnameField.placeholder = "Last name"
        self.doodleNameField.placeholder = "Doodle name"
        
        self.firstnameField.hidden = true
        self.lastnameField.hidden = true
        self.doodleNameField.hidden = true
        
        self.firstnameField.enabled = false
        self.lastnameField.enabled = false
        self.doodleNameField.enabled = false
        
        
        let views: Dictionary = [ "button": self.doodleButton, "image": self.doodleImageView, "first": self.firstnameField, "last": self.lastnameField, "doodleName": self.doodleNameField ]
        
        self.doodleButton.addTarget(self, action: "showDoodleView", forControlEvents: UIControlEvents.TouchUpInside)
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[first(==50)][last(==50)][doodleName(==50)]-(<=0)-[image]-(<=0)-[button(==100)]|", options: nil, metrics: nil, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[button]|", options: nil, metrics: nil, views: views))
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(<=0)-[image]-(<=0)-|", options: nil, metrics: nil, views: views))
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[first]|", options: nil, metrics: nil, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[last]|", options: nil, metrics: nil, views: views))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[doodleName]|", options: nil, metrics: nil, views: views))
        
        self.doodleImageView.contentMode = UIViewContentMode.Center
    }
    
    func showDoodleView()
    {
        var svc = SignatureViewController()
        
        svc.completion = { (signature: Signature!) -> Void in

            if (signature != nil) {
                var image = signature.imageWithSize(CGSize(width: self.doodleImageView.frame.size.width - 10.0, height: self.doodleImageView.frame.size.height - 10.0), color: UIColor.blackColor())
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let doodle = Doodle.newDoodle()
                    
                    let imageData = UIImagePNGRepresentation(image)
                    doodle.image = imageData
                    
                    CoreDataStack.sharedInstance.saveContext()
                })
                
            }
            
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                self.fetchData()
            })
        }
        
        let nav = UINavigationController(rootViewController: svc)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //==========================================================================
    // MARK: Data
    //==========================================================================
 
    func fetchData() {
        data = Doodle.allDoodles()
        collectionView.reloadData()
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
        
        collectionView.registerClass(DoodleCollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        return collectionView
        }()
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! DoodleCollectionViewCell
        
        let doodle = data[indexPath.row]
        
        let imageData = doodle.image
        
        if let image = UIImage(data: imageData) {
            cell.doodleImageView.image = image
        }
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Tapped \(indexPath)")
    }
    
}
