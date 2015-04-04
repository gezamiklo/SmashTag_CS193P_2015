//
//  TweetTableViewController.swift
//  SmashTag
//
//  Created by Géza Mikló on 30/03/15.
//  Copyright (c) 2015 Géza Mikló. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate {

    var tweets = [[Tweet]]()
    
    var lastSuccessFulRequest : TwitterRequest?
    
    var nextRequestToAttempt: TwitterRequest? {
        if lastSuccessFulRequest == nil {
            if searchText != nil {
                return TwitterRequest(search: searchText!, count: 100)
            } else {
                return lastSuccessFulRequest!.requestForNewer
            }
        }
        return nil
    }
    
    var searchText : String? = "#stanford" {
        didSet {
            lastSuccessFulRequest = nil
            tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
    }
    

    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    private struct StoryBoard {
        static let tweetCellReuseID = "Tweet Cell"
    }
    
    // MARK: View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
        
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
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return tweets[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.tweetCellReuseID, forIndexPath: indexPath) as TweetTableViewCell

        cell.tweet = tweets[indexPath.section][indexPath.row]

        return cell
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "Show tweet" {
            if let destVC = segue.destinationViewController as? TweetDetailTableViewController {
                if let indexPath = tableView.indexPathForSelectedRow() {
                    destVC.tweet = tweets[indexPath.section][indexPath.row]
                }
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            //Hide the keyboard
            textField.resignFirstResponder()
            searchText = searchTextField.text
        }
        return true
    }
    
    func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
            refresh(refreshControl!)
        }
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        if searchText != nil {
            if let request = nextRequestToAttempt {
                request.fetchTweets { (tweetsList) -> Void in
                    dispatch_async(dispatch_get_main_queue()) {
                        () -> Void in
                        if tweetsList.count > 0 {
                            for tweet in tweetsList {
                                self.tweets.insert(tweetsList, atIndex: 0)
                                println(tweet)
                                self.tableView.reloadData()
                                sender.endRefreshing()
                            }
                        }
                        
                    }
                }
                
            }
        }
    }

}
