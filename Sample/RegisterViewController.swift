//
//  RegisterViewController.swift
//  Sample
//
//  Created by 池沢将人 on 2019/06/23.
//  Copyright © 2019 池沢将人. All rights reserved.
//

import UIKit
import Alamofire
import Photos
import RxCocoa
import RxSwift

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var nameText: String = ""
    var ageText: String = ""
    var thumbnailImage: UIImage?
    var gesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        let _ = self.nameTextField.rx.text.subscribe(onNext: { [weak self] text in
            self?.nameText = text ?? ""
        })
        self.ageTextField.keyboardType = .numberPad
        let _ = self.ageTextField.rx.text.subscribe(onNext: { [weak self] text in
            self?.ageText = text ?? ""
        })
 
        let _ = gesture.rx.event.subscribe(onNext: { _ in
            if PHPhotoLibrary.authorizationStatus() != .authorized {
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized {
                        // フォトライブラリを表示する
                        let picker = UIImagePickerController()
                        picker.sourceType = .photoLibrary
                        picker.delegate = self
                        self.present(picker, animated: true, completion: nil)
                    } else if status == .denied {
                        // フォトライブラリへのアクセスが許可されていないため、アラートを表示する
                        let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
                        let settingsAction = UIAlertAction(title: "設定", style: .default, handler: { (_) -> Void in
                            guard let settingsURL = URL(string: UIApplication.openSettingsURLString ) else {
                                return
                            }
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        })
                        let closeAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
                        alert.addAction(settingsAction)
                        alert.addAction(closeAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                // フォトライブラリを表示する
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }
        })
        self.thumbnailImageView.layer.cornerRadius = 100.0
        self.thumbnailImageView.layer.masksToBounds = true
        self.thumbnailImageView.isUserInteractionEnabled = true
        self.thumbnailImageView.addGestureRecognizer(gesture)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        self.thumbnailImage = image
        self.thumbnailImageView.contentMode = .scaleAspectFill
        self.thumbnailImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "プロフィール登録"
        let rightButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil)
        self.navigationItem.setRightBarButtonItems([rightButton], animated: true)
        let _ = rightButton.rx.tap.subscribe({[weak self] _ in
            self?.registerUser()
        })
    }
    

    func registerUser() {
        if self.nameText.isEmpty {
            self.showError()
            return
        }
        if self.ageText.isEmpty {
            self.showError()
            return
        }
        
        let indicator = UIActivityIndicatorView(frame: self.view.frame)
        indicator.color = .gray
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]
        let parameters:[String: Any] = [
            "name": self.nameText,
            "age": Int(self.ageText) ?? 0,
        ]
        
//        Alamofire.request("https://zwtin.com/user", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//            .response(completionHandler: {[weak self] response in
//                indicator.stopAnimating()
//                indicator.removeFromSuperview()
//                self?.showAlert()
//            })
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(UIImage(named: "giants.jpg")?.jpegData(compressionQuality: 1.0) ?? Data(), withName: "uploaded", fileName: "giants.jpg", mimeType: "image/jpeg")
        }, to: "https://zwtin.com/", encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.response{ response in
                    // 成功
                    let responseData = response
                    print("成功")
                    print(responseData ?? "成功")
                }
            case .failure(let encodingError):
                // 失敗
                print("失敗")
                print(encodingError)
            }
        })
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "登録完了", message: "アカウントの登録に成功しました", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:{[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError() {
        let alert = UIAlertController(title: "エラー", message: "入力の値が不正です", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}