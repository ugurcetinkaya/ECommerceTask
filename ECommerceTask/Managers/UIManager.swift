//
//  UIManager.swift
//  ECommerceTask
//
//  Created by Ugur Cetinkaya on 3.11.2017.
//  Copyright © 2017 Ugur Cetinkaya. All rights reserved.
//

import KRProgressHUD

struct UIManager {
    
    static func showHUD() {
        KRProgressHUD.show()
    }
    
    static func dismissHUD() {
        KRProgressHUD.dismiss()
    }
}
