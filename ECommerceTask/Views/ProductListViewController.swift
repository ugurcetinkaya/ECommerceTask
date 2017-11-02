//
//  ProductListViewController.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 2.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit

final class ProductListViewController: BaseViewController {
    
    private var viewModel = ProductListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchProfileList()
    }

    func fetchProfileList() {
//        UIManager.showHUD()
        viewModel.getProductList()
            .on(failed: { (error) in
//                UIManager.dismissHUD()
            },completed: {
//                UIManager.dismissHUD()
                
            })
            .start()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
