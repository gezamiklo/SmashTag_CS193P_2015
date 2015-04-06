//
//  TwettUrlDetailTableViewCell.swift
//  SmashTag
//
//  Created by Géza Mikló on 04/04/15.
//  Copyright (c) 2015 Géza Mikló. All rights reserved.
//

import UIKit

class TweetUrlDetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            if let url = textLabel?.text {
                if let openUrl = NSURL(string: url) {
                    UIApplication.sharedApplication().openURL(openUrl)
                }
            }
        }
    }

}
