//
//  UnsplashDetailTitleCell.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import UIKit
import SDWebImage
class UnsplashDetailTitleCell: UITableViewCell {
    
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var author: UILabel!
    
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
        author.text = unsplash.author
        descrip.text = unsplash.url
    }
    
    
    
}

extension UnsplashDetailTitleCell: ReusableCell {
    
    static var ReuseIdentifier: String {
        return "UnsplashDetailTitleCell"
    }
    
    static var NibName: String {
        return "UnsplashDetailTitleCell"
    }
}
