//
//  GCPTestViewController.swift
//  Sample
//
//  Created by 池沢将人 on 2019/06/23.
//  Copyright © 2019 池沢将人. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GCPTestViewController: UIViewController {
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "GCPサンプル"
        
        let _ = registerBtn.rx.tap.subscribe({[weak self] _ in
            self?.registerProfile()
        })
        let _ = profileBtn.rx.tap.subscribe({[weak self] _ in
            self?.checkMyProfile()
        })
    }
    
    func registerProfile() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func checkMyProfile() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
