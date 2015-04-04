//
//  TweetImageDetailTableViewCell.swift
//  SmashTag
//
//  Created by Géza Mikló on 04/04/15.
//  Copyright (c) 2015 Géza Mikló. All rights reserved.
//

import UIKit

class TweetImageDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImageView: UIImageView!
    
    var aspectRatioConstraint : NSLayoutConstraint? {
        willSet {
            if let existintgConstraint = aspectRatioConstraint {
                removeConstraint(existintgConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstraint {
                addConstraint(newConstraint)
            }
        }
    }
    
    var tweetImage : UIImage? {
        get {
            return tweetImageView.image
        }
        set {
            tweetImageView.image = newValue
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

extension UIImage {
    var aspectRatio : CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}
