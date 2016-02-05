//
//  TwitterClient.swift
//  Twitter
//
//  Created by Bryan Rivera on 2/2/16.
//  Copyright © 2016 Bryan Rivera. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "58Jf9D7Q0Vxv7OILCr6xZVGeE"
let twitterConsumerSecret = "fMygCSf9YPGTtYZh1X7imFpI50WGzrC3VQRajyVlAUwugxmUKB"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
