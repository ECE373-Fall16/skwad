//
//  PostTableViewCell.swift
//  Skwad
//
//  Created by Corey Smith on 10/29/16.
//  Copyright © 2016 Corey Smith. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var time: UILabel!

    @IBOutlet weak var upVote: UIButton!
    @IBOutlet weak var comments: UIButton!
    
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
