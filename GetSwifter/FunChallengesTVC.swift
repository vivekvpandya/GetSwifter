//
//  FunChallengesTVC.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit

import Alamofire

class FunChallengesTVC: UITableViewController,UIAlertViewDelegate{
    
    
    // URL to get details in JSON format
    let serviceEndPoint = "http://tc-search.herokuapp.com/challenges/v2/search?q=technologies:Swift%20AND%20-status:(Completed%20OR%20Cancelled%20-%20Failed%20Screening)"
    
    var funChallenges :[NSDictionary] = [] {
        
        didSet{
            
            
            self.tableView!.reloadData()
        }
        
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getFunChallenges()
        
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
        return funChallenges.count
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        let cell = tableView!.dequeueReusableCellWithIdentifier("funChalllenges", forIndexPath: indexPath!) as UITableViewCell
        
        
        var details = funChallenges[indexPath!.row] as NSDictionary
        var source = details.objectForKey("_source") as NSDictionary
        
        cell.textLabel?.text = source.objectForKey("challengeName") as NSString
        var prize =  source.objectForKey("totalPrize") as Int
        cell.detailTextLabel?.text = "$ \(prize)"
        
        
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
        
        var destinationVC : FunChallengeDetailsVC = segue.destinationViewController as FunChallengeDetailsVC
        
        let indexPath :NSIndexPath  = self.tableView.indexPathForCell(sender as UITableViewCell)!
        
        var details = funChallenges[indexPath.row] as NSDictionary
        var source = details.objectForKey("_source") as NSDictionary
        
        
        destinationVC.challengeID = details.objectForKey("_id") as NSString
        
        // Pass the selected object to the new view controller.
    }
    
    
    
    func getFunChallenges() {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET,serviceEndPoint, encoding : .JSON).responseJSON{(request,response,JSON,error) in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if error == nil {
                
                if response?.statusCode == 200 {
                    
                    self.funChallenges = JSON as [NSDictionary]
                    
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
        
        
        getFunChallenges()
        self.refreshControl?.endRefreshing()
    }
    
    
    
    
}
