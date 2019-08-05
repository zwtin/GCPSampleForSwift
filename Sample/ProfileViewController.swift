//
//  ProfileViewController.swift
//  Sample
//
//  Created by 池沢将人 on 2019/06/23.
//  Copyright © 2019 池沢将人. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userTableView: UITableView!
    var data: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "プロフィール一覧"
        self.getData()
        userTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        userTableView.delegate = self
        userTableView.dataSource = self
    }
    
    func getData() {
        Alamofire.request("https://zwtin.com/user", method: .get)
            .response(completionHandler: { response in
                                
                let decoder: JSONDecoder = JSONDecoder()
                do {
                    let array: [User] = try decoder.decode([User].self, from: response.data ?? Data())
                    self.data = []
                    array.forEach({ user in
                        if user.DeletedAt == nil {
                            self.data.append(user)
                        }
                    })
                    self.userTableView.reloadData()
                } catch {
                    print("error:", error.localizedDescription)
                }
            })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTableViewCell
        cell.setup(info: self.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "確認", message: "このユーザーを削除しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:{[weak self] _ in
            let headers: HTTPHeaders = ["Contenttype": "application/json"]
            let parameters:[String: Any] = ["id": self?.data[indexPath.row].ID ?? 0]
            
            Alamofire.request("https://zwtin.com/user", method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .response(completionHandler: { [weak self] _ in
                    self?.getData()
                })
        })
        let noAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
        userTableView.deselectRow(at: indexPath, animated: true)
    }
}

struct UserArray: Codable {
    let user: [User]
}

struct User: Codable {
    let ID: Int?
    let CreatedAt: String?
    let UpdatedAt: String?
    let DeletedAt: String?
    var name: String?
    var age: Int?
    var image: String?
}
