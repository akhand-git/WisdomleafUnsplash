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
        descrip.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
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
