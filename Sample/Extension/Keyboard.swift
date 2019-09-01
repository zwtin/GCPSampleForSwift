//
//  Keyboard.swift
//  Sample
//
//  Created by zwtin on 2019/08/24.
//  Copyright © 2019 zwtin. All rights reserved.
//

import RxSwift
import RxCocoa

class Keyboard {
    static let observableHeight: Observable<CGFloat> = Observable.from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> CGFloat in
                        (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { _ -> CGFloat in
                        0
                }
                ])
            .merge()
    
    static let observableDuration: Observable<Double> = Observable.from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> Double in
                        (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.0
                },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { notification -> Double in
                        (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.0
                }
                ])
            .merge()
    
    static let observableInfo: Observable<(CGFloat, Double)> = Observable.zip(Keyboard.observableHeight, Keyboard.observableDuration)
}
