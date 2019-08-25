//
//  Keyboard.swift
//  Sample
//
//  Created by 池沢将人 on 2019/08/24.
//  Copyright © 2019 池沢将人. All rights reserved.
//

import RxSwift
import RxCocoa

class Keyboard {
    func observableHeight() -> Observable<CGFloat> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> CGFloat in
                        (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
//                        (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey].)
                },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { _ -> CGFloat in
                        0
                }
                ])
            .merge()
    }
}
