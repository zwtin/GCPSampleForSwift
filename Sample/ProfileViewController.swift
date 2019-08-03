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
                    self.data = array
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
        userTableView.deselectRow(at: indexPath, animated: true)
    }
}

struct UserArray: Codable {
    let user: [User]
}

struct User: Codable {
    let id: Int?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    var name: String?
    var age: Int?
}
