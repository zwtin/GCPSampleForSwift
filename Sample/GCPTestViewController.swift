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

class GCPTestViewController: UIBaseViewController {
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var chatRoomBtn: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "GCPサンプル"
        
        _ = registerBtn.rx.tap.subscribe({[weak self] _ in
            self?.registerProfile()
        }).disposed(by: disposeBag)
        
        _ = profileBtn.rx.tap.subscribe({[weak self] _ in
            self?.checkMyProfile()
        }).disposed(by: disposeBag)
        
        _ = chatRoomBtn.rx.tap.subscribe({[weak self] _ in
            self?.startChatRoom()
        }).disposed(by: disposeBag)
    }
    
    func registerProfile() {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func checkMyProfile() {
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func startChatRoom() {
        let chatRoomViewController = ChatRoomViewController()
        self.navigationController?.pushViewController(chatRoomViewController, animated: true)
    }
}
