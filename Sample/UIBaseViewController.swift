//
//  UIBaseViewController.swift
//  Sample
//
//  Created by 池沢将人 on 2019/08/18.
//  Copyright © 2019 池沢将人. All rights reserved.
//

import UIKit
import Toast_Swift

class UIBaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let className: String = NSStringFromClass(type(of: self))
        self.view.makeToast(className, duration: 3.0, position: .center, title: nil, image: nil, style: .init(), completion: nil)
    }
}
