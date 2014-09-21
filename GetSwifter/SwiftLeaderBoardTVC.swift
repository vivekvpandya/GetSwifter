//
//  SwiftLeaderBoardTVC.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/21/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit

import Alamofire

class SwiftLeaderBoardTVC: UITableViewController,UIAlertViewDelegate{
    
    
    // URL to get details in JSON format
    let serviceEndPoint = "http://tc-leaderboard.herokuapp.com/getswifter"
    
    var leaders :[NSDictionary] = [] {
        
        didSet{
            
            
            self.tableView!.reloadData()
        }
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getSwiftLeaders()
        
        //realWorldChallenges = ["Vivek","Pandya"]
        
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
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        
        // println(self.realWorldChallenges.count)
        return leaders.count
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        let cell = tableView!.dequeueReusableCellWithIdentifier("swiftLeader", forIndexPath: indexPath!) as SwiftLeaderTableViewCell
        
        
        var details = leaders[indexPath!.row] as NSDictionary
       var handle = details.objectForKey("handle") as NSString
        cell.handleLabel.text = "\(handle)"
        var rank = details.objectForKey("rank") as Int
        cell.rankLabel.text = "#\(rank)"
        var score = details.objectForKey("score") as Double
        cell.scoreLabel.text = "\(score)"
        var profileImageURLString:NSString =  details.objectForKey("pic") as NSString
        
        cell.circularProfileView.image = UIImage(data:NSData(contentsOfURL: NSURL(string: profileImageURLString)))
    
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return false
    }
    
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
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
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        // Get the new view controller using [segue destinationViewController].
        
        var destinationVC : RealWorldChallengeDetailsVC = segue.destinationViewController as RealWorldChallengeDetailsVC
        
        let indexPath :NSIndexPath  = self.tableView.indexPathForCell(sender as UITableViewCell)!
        
        var details = leaders[indexPath.row] as NSDictionary
        var source = details.objectForKey("_source") as NSDictionary
        
        
        destinationVC.challengeID = details.objectForKey("_id") as NSString
        
        // Pass the selected object to the new view controller.
    }
    
    
    
    func getSwiftLeaders() {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET,serviceEndPoint, encoding : .JSON).responseJSON{(request,response,JSON,error) in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if error == nil {
                
                if response?.statusCode == 200 {
                    
                    self.leaders = JSON as [NSDictionary]
                    
                }
                else{
                    
                    var alert  = UIAlertView(title:"Error" , message:"Sorry! error in details loading. " , delegate:self, cancelButtonTitle:"Dismiss")
                    alert.show()
                    
                    
                }
                
            }
            else{
                
                var alert  = UIAlertView(title:"Error" , message:"Sorry! error in details loading. " , delegate:self, cancelButtonTitle:"Dismiss")
                alert.show()
                
                
            }
            
            
        }
        
    }
    
    
    @IBAction func refreshTableView(sender: AnyObject) {
        
        
        getSwiftLeaders()
        self.refreshControl?.endRefreshing()
    }
    
    
    
    
}
