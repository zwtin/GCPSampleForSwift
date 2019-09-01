//
//  ChatRoomViewController.swift
//  Sample
//
//  Created by zwtin on 2019/08/19.
//  Copyright © 2019 zwtin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ChatRoomViewController: UIBaseViewController, UITextViewDelegate {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageSendBtn: UIButton!
    @IBOutlet weak var view2BottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Keyboard.observableInfo.subscribe(onNext: { [weak self] info in
            self?.view.layoutIfNeeded()
            self?.view2BottomConstraint.constant = -info.0 + (self?.view.safeAreaInsets.bottom ?? 0.0)
            UIView.animate(withDuration: info.1, animations: {
                self?.view.layoutIfNeeded()
            })
        }).disposed(by: disposeBag)
        
        messageTextView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        _ = messageTextView.rx.text.changed.subscribe(onNext: {[weak self] _ in
            let height = self?.messageTextView.sizeThatFits(CGSize(width: self?.messageTextView.frame.size.width ?? 0.0,
                                                height: CGFloat.greatestFiniteMagnitude)).height ?? 0.0
            self?.messageTextViewHeightConstraint.constant = height
        }).disposed(by: disposeBag)
        
        _ = messageSendBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.messageTextView.text = ""
        }).disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
