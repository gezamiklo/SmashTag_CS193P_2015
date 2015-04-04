//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by Géza Mikló on 30/03/15.
//  Copyright (c) 2015 Géza Mikló. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet : Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    func updateUI() {
        tweetTextLabel?.attributedText = nil
        userScreenNameLabel.text = nil
        userImage?.image = nil
        
        if let tweet = self.tweet {
            var tweetText = tweet.text
            
            for _ in tweet.media {
                tweetText += " 📷"
            }
            
            var attributedText = NSMutableAttributedString(string: tweetText)
            
            let keywordAttributes = [NSForegroundColorAttributeName: UIColor.blueColor(), NSBackgroundColorAttributeName: UIColor.yellowColor(), NSUnderlineStyleAttributeName: 1]
            
            for hashTag in tweet.hashtags {
                attributedText.addAttributes(keywordAttributes, range: hashTag.nsrange)
            }
            
            let userAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSBackgroundColorAttributeName: UIColor.blueColor(), NSUnderlineStyleAttributeName: 0]
            
            for userTag in tweet.userMentions {
                attributedText.addAttributes(userAttributes, range: userTag.nsrange)
            }

            tweetTextLabel.attributedText = attributedText
            
            userScreenNameLabel?.text = tweet.user.screenName
            if let profileImageURL = tweet.user.profileImageURL {
                //Blocks the main thread
                if let imageData = NSData(contentsOfURL: profileImageURL) {
                    userImage?.image = UIImage(data: imageData)
                }
            }
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
