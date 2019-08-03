//
//  ViewController.swift
//  Sample
//
//  Created by 池沢将人 on 2019/06/02.
//  Copyright © 2019 池沢将人. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView?
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         self.view.backgroundColor = UIColor.lightGray
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:130, height:170)
        layout.sectionInset = UIEdgeInsets(top: 0,left: 20,bottom: 0,right: 20)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30

        //ここでコレクションビューに紐付け
        
        let frame = CGRect(x: 0, y: self.view.frame.size.height/2.0-100, width: self.view.frame.size.width, height: 200)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.register(UINib(nibName: "SampleCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(collectionView!)
        
        let label = self.setupNameLabel(name: "ふるかわ", size: .zero)
        self.view.addSubview(label)
        
        let btn: UIButton = UIButton(frame: CGRect(x: self.view.frame.size.width/2.0 - 50.0,
                                                   y: self.view.frame.size.height/2.0 + 150,
                                                   width: 100.0,
                                                   height: 100.0))
        btn.backgroundColor = UIColor.blue
        self.view.addSubview(btn)
        
        let _ = btn.rx.tap.subscribe({[weak self] _ in
            self?.startScreen()
        })
    }
    
    func startScreen() {
        let vc = GCPTestViewController()
        let nvc = UINavigationController(rootViewController: vc)
        
        self.present(nvc, animated: true, completion: nil)
    }
    
    func setupNameLabel(name: String, size: CGRect) -> UILabel {
        return UILabel()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SampleCell
        switch indexPath.row {
        case 0:
            cell.image.image = UIImage(named: "carp")
            cell.label.text = "広島東洋カープ"
            
        case 1:
            cell.image.image = UIImage(named: "swallows")
            cell.label.text = "東京ヤクルトスワローズ"

        case 2:
            cell.image.image = UIImage(named: "giants")
            cell.label.text = "読売ジャイアンツ"

        case 3:
            cell.image.image = UIImage(named: "baysters")
            cell.label.text = "横浜DeNAベイスターズ"

        case 4:
            cell.image.image = UIImage(named: "dragons")
            cell.label.text = "中日ドラゴンズ"

        case 5:
            cell.image.image = UIImage(named: "tigers")
            cell.label.text = "阪神タイガース"

        default:
            break
        }
        
        return cell
    }
}

