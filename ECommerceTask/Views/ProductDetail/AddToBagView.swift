//
//  AddToBagView.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 11.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit

import Stepperier

@objc
public protocol AddToBagViewDelegate {
    func actionAddToCart()
}

class AddToBagView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var addToCartButton: UIButton!
    @IBOutlet private weak var stepperView: UIView!
    lazy var stepperier = Stepperier()
    
    public weak var delegate: AddToBagViewDelegate?

    
    // for using in cod
    override init(frame: CGRect) {
        super.init(frame: frame)
        commentInit()
    }
    
    //for using in InterfaceBuilder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commentInit()
    }
    
    private func commentInit() {
        contentView = Bundle.main.loadNibNamed("AddToBagView", owner: self, options: nil)?.first as! UIView
        contentView.frame = bounds
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        stepperier.backgroundColor = UIColor.purple
        stepperView.addSubview(stepperier)
        // Setup layout constraints
        stepperier.translatesAutoresizingMaskIntoConstraints = false
        stepperier.centerXAnchor.constraint(equalTo: stepperView.centerXAnchor).isActive = true
        stepperier.centerYAnchor.constraint(equalTo: stepperView.centerYAnchor).isActive = true
        stepperier.heightAnchor.constraint(equalTo: stepperView.heightAnchor).isActive = true
        stepperier.widthAnchor.constraint(equalTo: stepperView.widthAnchor).isActive = true
        
        addToCartButton.addTarget(self, action: #selector(tapAddToCart), for: .touchUpInside)
        addToCartButton.layer.cornerRadius = 22
        
    }

    func tapAddToCart() {
        delegate?.actionAddToCart()
    }
    
}
