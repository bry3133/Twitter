//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Bryan Rivera on 2/14/16.
//  Copyright © 2016 Bryan Rivera. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var characterLimitLabel: UILabel!
    @IBOutlet weak var sendButton1: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance.myCredentials() { (user, error) -> () in
            self.user = user
            
        if (user.name != nil) {
           self.usernameLabel.text = user.name
        }
        if (user.screenname != nil) {
            self.handleLabel.text = user.screenname
        }
        if (user.profileImageUrl != nil) {
            self.profileImage.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        }
        self.tweetText.delegate = self

        
        // Do any additional setup after loading the view.
        }

        
    }
    @IBAction func textViewDidBeginEditing(textView: UITextView) {
        print("changed")
        let temp = tweetText.text
        let numTemp = temp?.characters.count
        characterLimitLabel.text = "\(140 - numTemp!)"
        if (Int(characterLimitLabel.text!)! <= 0) {
            tweetText.text = String(tweetText.text!.characters.dropLast())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPushed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func sendButton(sender: AnyObject) {
        if (tweetText.text != nil) {
            let messageToSend = tweetText.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            TwitterClient.sharedInstance.makeTweet(messageToSend)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
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
