//
//  TweetsTableViewCell.swift
//  Twitter
//
//  Created by Bryan Rivera on 2/7/16.
//  Copyright © 2016 Bryan Rivera. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            if (tweet.text != nil) {
                tweetLabel.text = tweet.text
            }
            if (tweet.user?.name != nil) {
                usernameLabel.text = tweet.user!.name
            }
            if (tweet.user?.profileImageUrl != nil) {
                profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            }
//            if (tweet.createdAtString != nil) {
//                timeStampLabel.text = "\(tweet.createdAtString!)"
//            }
            if (tweet.user?.screenname != nil) {
                handleLabel.text = "@\(tweet.user!.screenname!)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
