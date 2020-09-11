//
//  UnsplashDetailCell.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//


import UIKit
import SDWebImage

class UnsplashDetailCell: UITableViewCell {

    @IBOutlet weak var unsplashImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
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
        request = SDWebImageManager.shared().loadImage(with: URL(string:unsplash.download_url ?? ""), options: .highPriority, progress: nil) { [weak self] (image, _, error, _, finished, url) in
            if URL(string: unsplash.download_url ?? "") == url  {
                      if let `image`: UIImage = image {
                          self?.unsplashImg.image = image
                      } else  {
                      }
                  }
              }
    }
    
    
}

extension UnsplashDetailCell: ReusableCell {
    
    static var ReuseIdentifier: String {
        return "UnsplashDetailCell"
    }
    
    static var NibName: String {
        return "UnsplashDetailCell"
    }
}
