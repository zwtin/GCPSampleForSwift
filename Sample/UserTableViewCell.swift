//
//  UserTableViewCell.swift
//  Sample
//
//  Created by 池沢将人 on 2019/07/01.
//  Copyright © 2019 池沢将人. All rights reserved.
//

import UIKit
import Alamofire

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: AsyncImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(info: User) {
        userImageView.loadImage(from: "https://storage.googleapis.com/hello-world-243909.appspot.com/carp.jpg")
        userNameLabel.text = "ユーザー名：\(info.name ?? "")\n年齢：\(info.age ?? 0)"
    }
}
