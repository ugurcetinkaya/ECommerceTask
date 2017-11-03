//
//  ProductListViewController.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 2.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit

final class ProductListViewController: BaseViewController {
    
    let viewModel = ProductListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    let kCellIdentifier = "ProductTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        self.fetchProfileList()
    }

    func fetchProfileList() {
//        UIManager.showHUD()
        viewModel.getProductList()
            .on(failed: { (error) in
//                UIManager.dismissHUD()
            },completed: {
//                UIManager.dismissHUD()
                self.tableView.reloadData()
            })
            .start()
    }
}

// MARK: - UITableView Delegate & DataSource
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product: ProductModel = viewModel.productList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! ProductTableViewCell
        cell.selectionStyle = .none
        cell.setProductCell(with: product)
        
        return cell
    }
}
