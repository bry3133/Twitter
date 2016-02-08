//
//  TwitterClient.swift
//  Twitter
//
//  Created by Bryan Rivera on 2/2/16.
//  Copyright © 2016 Bryan Rivera. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterbaseURL = NSURL(string: "https://api.twitter.com/")
let twitterConsumerKey: String = "VsSAwljv8SsELIsA3w6O8qrjk"
let twitterConsumerSecret: String = "s0voKIp4Iqe36RpW7ZjnFWBYFPAHa0U79PoUSXXCSXPXxEEOZm"

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterbaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "Get", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Failed to get the request")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet], error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            //             print("Timeline: \(response)")
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failed to get timeline")
                completion(tweets: [], error: nil)
        })
    }
    
    func favoriteMe(id: String) {
        POST("https://api.twitter.com/1.1/favorites/create.json?id=\(id)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Succesfully favorited")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to favorite")
        }
    }
    func unFavoriteMe(id: String) {
        POST("https://api.twitter.com/1.1/favorites/destroy.json?id=\(id)", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Succesfully favorited")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to favorite")
        }
    }
    
    func retweetMe(id: String) {
        POST("https://api.twitter.com/1.1/statuses/retweet/\(id).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully retweeted")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to retweet")
        }
    }
    func unRetweetMe(id: String) {
        POST("https://api.twitter.com/1.1/statuses/unretweet/\(id).json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("Successfully retweeted")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Failed to retweet")
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                // print("User: \(response)")
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                print("User: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("Did not get user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
}
