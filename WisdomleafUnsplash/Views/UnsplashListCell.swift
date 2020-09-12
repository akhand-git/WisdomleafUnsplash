//
//  UnsplashListCell.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import UIKit
import SDWebImage

class UnsplashListCell: UITableViewCell {

    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var unsplashImg: UIImageView!
    @IBOutlet weak var unsplashImgView: UIView!
    @IBOutlet weak var optionBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupPlayerView()
        // Initialization code
    }
    
    
    var request: SDWebImageOperation? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    //MARK: Layout Setup
    func setup(unsplash: Unsplash) {
        author.text = unsplash.author
        unsplashImg.image = UIImage(named: "placeholder-image")
        request = SDWebImageManager.shared().loadImage(with: URL(string:unsplash.download_url ?? ""), options: .highPriority, progress: nil) { [weak self] (image, _, error, _, finished, url) in
            if URL(string: unsplash.download_url ?? "") == url  {
                      if let `image`: UIImage = image {
                          self?.unsplashImg.image = image
                      } else  {
                      }
                  }
              }
        descrip.text = unsplash.url
    }
    
    fileprivate func setupPlayerView() {
        unsplashImgView.backgroundColor = UIColor.darkBlack
        unsplashImgView.layer.cornerRadius = unsplashImgView.bounds.width / 2.0
        
        unsplashImgView.makeOutwardNeomorphic(reversed: false, offsetValue: 15.0, shadowRadius: 15.0, alphaLight: 0.1, alphaDark: 0.2)
        
        unsplashImg.contentMode = .scaleToFill
        unsplashImg.layer.cornerRadius = unsplashImg.bounds.width / 2.0
        unsplashImg.layer.masksToBounds = true
    }
    
}

extension UnsplashListCell: ReusableCell {
    
    static var ReuseIdentifier: String {
        return "UnsplashListCell"
    }
    
    static var NibName: String {
        return "UnsplashListCell"
    }
}
