//
//  UnsplashDetailVC.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import UIKit

class UnsplashDetailVC: UIViewController {
    var gradientLayer = CAGradientLayer()
    @IBOutlet weak var tableView: UITableView!
    var unsplash: Unsplash?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.lightBlack.cgColor, UIColor.darkBlack.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        UnsplashDetailCell.registerNibForTable(self.tableView)
        UnsplashDetailTitleCell.registerNibForTable(self.tableView)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension UnsplashDetailVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: UnsplashDetailCell.ReuseIdentifier, for: indexPath) as! UnsplashDetailCell
            cell.setup(unsplash: unsplash!)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: UnsplashDetailTitleCell.ReuseIdentifier, for: indexPath) as! UnsplashDetailTitleCell
            cell.setup(unsplash: unsplash!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
