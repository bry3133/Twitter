//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Bryan Rivera on 2/14/16.
//  Copyright © 2016 Bryan Rivera. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetCtLabel: UILabel!
    @IBOutlet weak var followingCtLabel: UILabel!
    @IBOutlet weak var followerCtLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: User!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = tweet.user!.name
        
        profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
        profileImage.layer.cornerRadius = 5;
        profileImage.clipsToBounds = true
        
        headerImage.setImageWithURL(NSURL(string: tweet.user!.headerImageUrl!)!)
        tweetCtLabel.text = "\(tweet.user!.tweetCount!)"
        followingCtLabel.text = "\(tweet.user!.followingCount!)"
        followerCtLabel.text = "\(tweet.user!.followerCount!)"
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
