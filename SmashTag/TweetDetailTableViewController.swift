//
//  TweetDetailTableViewController.swift
//  SmashTag
//
//  Created by Géza Mikló on 04/04/15.
//  Copyright (c) 2015 Géza Mikló. All rights reserved.
//

import UIKit

class TweetDetailTableViewController: UITableViewController, UITableViewDelegate {

    private struct StoryBoard {
        static let sectionHeaderId = "TweetDetailSectionHeader"
        static let textualDetailId = "TweetTextualDetail"
        static let imageDetailId = "TweetImageDetail"
    }
    
    let tweetSections = [
        "Keywords",
        "Users",
        "Media",
        "URLs"
    ]
    
    var tweet : Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return tweetSections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        switch section {
        case 0:
            return tweet!.hashtags.count
        case 1:
            return tweet!.userMentions.count
        case 2:
            return tweet!.media.count
        case 3:
            return tweet!.urls.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.sectionHeaderId) as TweetDetailSectionHeaderTableViewCell
        cell.headerLabel.text = tweetSections[section]
        return cell
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.textualDetailId, forIndexPath: indexPath) as TweetTextualDetailTableViewCell
                cell.textLabel?.text = tweet?.hashtags[indexPath.row].keyword
                return cell
            
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.textualDetailId, forIndexPath: indexPath) as TweetTextualDetailTableViewCell
                cell.textLabel?.text = tweet?.userMentions[indexPath.row].keyword
                return cell
            
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.imageDetailId, forIndexPath: indexPath) as TweetImageDetailTableViewCell
                if let imageURL = tweet?.media[indexPath.row].url {
                    if let imageData = NSData(contentsOfURL: imageURL) {
                        cell.tweetImage = UIImage(data: imageData)
                    }
                }
                return cell
            
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.textualDetailId, forIndexPath: indexPath) as TweetTextualDetailTableViewCell
                cell.textLabel?.text = tweet?.urls[indexPath.row].keyword
                return cell
            
            default:
                let cell = UITableViewCell()
                return cell
        }
    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 2 {
            if let mediaItem = tweet?.media[indexPath.row] {
                return CGFloat(Double(tableView.bounds.size.width) * mediaItem.aspectRatio)
            }
        }
        
        return UITableViewAutomaticDimension
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
