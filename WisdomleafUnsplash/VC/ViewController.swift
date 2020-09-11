//
//  ViewController.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import UIKit
import SDWebImage
import Photos
import AVFoundation
import Foundation

class UnsplashListVC: UIViewController {
    var allUnsplash: [Unsplash] = []
    var page  = 1
    var unsplashApi: UnsplashApi = UnsplashApi()
    var gradientLayer = CAGradientLayer()
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    var request: HTTPRequestManager? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    
    var requestImg: SDWebImageOperation? {
        didSet {
            oldValue?.cancel()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.barTintColor = UIColor.lightBlack
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.lightBlack.cgColor, UIColor.darkBlack.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        UnsplashListCell.registerNibForTable(self.tableView)
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refreshPage), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        fetchUnsplash()
        // Do any additional setup after loading the view.
    }
    
    
    @objc func refreshPage(){
        page = 1
        fetchUnsplash()
    }
    
    func fetchNextPageRecord(rowNo:Int)
    {
        if rowNo == allUnsplash.count-1
        {
            self.page += 1
            fetchUnsplash()
        }
    }
    
    //MARK:- Fetch all Unsplash API
    
    @objc func fetchUnsplash(completion:  (()->())? = nil) {
        
        request = unsplashApi.getAllUnsplash(for: page , completion: { (unsplash) in
            switch self.page {
            case 1:
                self.allUnsplash = unsplash ?? []
            default:
                self.allUnsplash.append(contentsOf: unsplash ?? [])
            }
            DispatchQueue.main.async() {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                completion?()
            }
        }, failure: { (error, code) in
            DispatchQueue.main.async {[] in
                self.tableView.reloadData()
                completion?()
            }
        })
    }
    
    
}
 //MARK:- TableView  Delegate & DataSource

extension UnsplashListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UnsplashListCell.ReuseIdentifier, for: indexPath) as! UnsplashListCell
        cell.setup(unsplash: allUnsplash[indexPath.row])
        fetchNextPageRecord(rowNo: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUnsplash.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UnsplashDetailVC") as? UnsplashDetailVC
        vc?.unsplash = allUnsplash[indexPath.row]
        self.present(vc!, animated: true, completion: nil)
    }
}
