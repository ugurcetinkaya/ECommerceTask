//
//  ProductDetailViewController.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 4.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import UIKit

import Kingfisher
import Agrume

final class ProductDetailViewController: BaseViewController {

    fileprivate let viewModel = ProductDetailViewModel()

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pricaLabel: UILabel!
    @IBOutlet weak var sizeField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToBagView: AddToBagView!
    
    var sizePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(actionImageTap))
        productImage.addGestureRecognizer(imageTapGesture)
        
        sizePicker = UIPickerView()
        sizePicker.delegate = self
        sizePicker.dataSource = self
        sizeField.inputView = sizePicker
        
        addToBagView.delegate = self
        
        self.fetchProductDetail()
    }

    private func fetchProductDetail() {
        UIManager.showHUD()
        viewModel.getProductDetail()
            .on(failed: { (error) in
                UIManager.dismissHUD()
            },completed: {
                UIManager.dismissHUD()
                
                self.setupUI()
            })
            .start()
    }
    
    private func setupUI() {
        productImage.kf.setImage(with: viewModel.productDetail.image)
        titleLabel.text = viewModel.productDetail.name
        pricaLabel.text = "\(String(describing: viewModel.productDetail.price!)) AED"
        descriptionLabel.attributedText = DataManager.stringFromHtml(string: viewModel.productDetail.description!)
        
        sizePicker.reloadAllComponents()
        let row = sizePicker.selectedRow(inComponent: 0);
        pickerView(sizePicker, didSelectRow: row, inComponent: 0)
    }
    
    //MARK: - Action
    @objc
    private func actionImageTap() {
        let agruma = Agrume(image: productImage.image!, backgroundBlurStyle: .extraLight)
        agruma.showFrom(self)
    }
}

extension ProductDetailViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.productDetail.sizes!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let size: ProductSizeModel = viewModel.productDetail.sizes![row]
        return size.label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let size: ProductSizeModel = viewModel.productDetail.sizes![row]
        
        viewModel.selectedSize = size
        
        sizeField.text = size.label
        addToBagView.stepperier.maximumValue = size.quantity
        addToBagView.stepperier.value = 0
    }
}

extension ProductDetailViewController: AddToBagViewDelegate {
    func actionAddToCart() {
        if addToBagView.stepperier.value != 0 {
            let alert = UIAlertController(title: "", message: "Products were added to your cart.", preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(doneAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
