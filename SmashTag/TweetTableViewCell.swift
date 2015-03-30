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
            tweetTextLabel?.text = tweet.text
            
            for _ in tweet.media {
                tweetTextLabel.text! += " 📷"
            }
            
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
