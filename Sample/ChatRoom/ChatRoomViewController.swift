//
//  ChatRoomViewController.swift
//  Sample
//
//  Created by 池沢将人 on 2019/08/19.
//  Copyright © 2019 池沢将人. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ChatRoomViewController: UIBaseViewController, UITextViewDelegate {
    
    let keyboard = Keyboard()
    let disposeBag = DisposeBag()
    @IBOutlet weak var view2BottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = keyboard.observableHeight().subscribe(onNext: { [weak self] height in
            self?.view.layoutIfNeeded()
            self?.view2BottomConstraint.constant = -height
            UIView.animate(withDuration: 0.5, animations: {
                self?.view.layoutIfNeeded()
            })
        }).disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
