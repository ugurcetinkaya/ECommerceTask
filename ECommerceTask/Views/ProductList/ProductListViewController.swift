//
//  ProductListViewController.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 2.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit

final class ProductListViewController: BaseViewController {
    
    fileprivate let viewModel = ProductListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    let kProductCellIdentifier = "ProductTableViewCell"
    let kPagingCellIdentifier = "PagingTableViewCell"
    let kPrductDetailSegue = "productDetailSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Boy Clothes"

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshProductList), for: .valueChanged)
        
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        
        UIManager.showHUD()
        self.fetchProfileList()
    }

    private func fetchProfileList(refresh: Bool = false) {
        viewModel.getProductList(isRefreshing: refresh)
            .on(failed: { (error) in
                UIManager.dismissHUD()
            },completed: {
                UIManager.dismissHUD()
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            })
            .start()
    }
    
    fileprivate func fetchNextPage() {
        viewModel.pageIndex += 1
        fetchProfileList()
    }
    
    @objc
    private func refreshProductList() {
        viewModel.pageIndex = 0
        fetchProfileList(refresh: true)
    }
}

// MARK: - UITableView Delegate & DataSource
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.productList.count
        return viewModel.shouldShowLoadingCell ?  count + 1 : count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingIndexPath(indexPath) {
            return PagingTableViewCell(style: .default, reuseIdentifier: kPagingCellIdentifier)
        } else {
            let product: ProductModel = viewModel.productList[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: kProductCellIdentifier, for: indexPath) as! ProductTableViewCell
            cell.selectionStyle = .none
            cell.setProductCell(with: product)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: kPrductDetailSegue, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        fetchNextPage()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard viewModel.shouldShowLoadingCell else { return false }
        return indexPath.row == viewModel.productList.count
    }
}
