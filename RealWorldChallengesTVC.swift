//
//  RealWorldChallengesTVC.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/19/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit
import Alamofire

class RealWorldChallengesTVC: UITableViewController,UIAlertViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate{
   
    
    
    // URL to get details in JSON format
    let serviceEndPoint = "http://tc-search.herokuapp.com/challenges/v2/search?q=challengeName:realworldswift%20AND%20-status:(Completed%20OR%20Cancelled%20-%20Failed%20Screening)"
    
    
    var serviceEndPoint1 : String = "http://api.topcoder.com/v2/develop/challenges/" // here challenge id will be appended at the end
    
   
    
    var realWorldChallenges :[NSDictionary] = [] {
    
        didSet{
        
        
            self.tableView!.reloadData()
        }
       
        
    }

    var searchResult : [NSDictionary] = []

    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        getRealWorldChallenges()

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
      
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.searchResult.count
        }
        else{
        
        return realWorldChallenges.count
        }
    }

    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("rwc", forIndexPath: indexPath!) as ChallengeDetailsTableViewCell

        var details : NSDictionary
        var source : NSDictionary
        
        if tableView == self.searchDisplayController?.searchResultsTableView{
            details = searchResult[indexPath!.row] as NSDictionary
        }
        else{
            details = realWorldChallenges[indexPath!.row] as NSDictionary

        
        }
        
         source = details.objectForKey("_source") as NSDictionary
        
        
        var dateFormater : NSDateFormatter = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        dateFormater.timeZone = NSTimeZone(name:"GMT")
        
        
        var opDateFormater : NSDateFormatter = NSDateFormatter()
        opDateFormater.timeZone = NSTimeZone(name:"GMT")
        opDateFormater.dateStyle=NSDateFormatterStyle.MediumStyle
        opDateFormater.timeStyle = NSDateFormatterStyle.LongStyle
        
        if let challengeName = source.objectForKey("challengeName") as? NSString {
        
        cell.challenge.text = challengeName
        }
        
        if let technology = source.objectForKey("technologies") as? NSArray {
            
            let technologyString = technology.componentsJoinedByString(",")
            cell.technologyLabel.text = technologyString
        
            
        }
        if let platform = source.objectForKey("platforms") as? NSArray {
        
        let platfromString = platform.componentsJoinedByString(",")
            cell.platformLabel.text = platfromString
        
        }
        if let regEnd = source.objectForKey("registrationEndDate") as? NSString {
        
            let regEndDate = dateFormater.dateFromString(regEnd)
            let regEndDateString = opDateFormater.stringFromDate(regEndDate!)
            cell.regEndLabel.text = regEndDateString
        
        }
        if let subEnd = source.objectForKey("submissionEndDate") as? NSString {
        
            let subEndDate = dateFormater.dateFromString(subEnd)
            let subEndDateString = opDateFormater.stringFromDate(subEndDate!)
            cell.subEndLabel.text = subEndDateString
        
        }
        if let registrants = source.objectForKey("numRegistrants") as? Int {
            
            cell.registrantsLabel.text = "\(registrants)"
        
        }
        
        if let submisions = source.objectForKey("numSubmissions") as? Int {
        
        cell.submissionsLabel.text = "\(submisions)"
        }
        
        if let totalPrize = source.objectForKey("totalPrize") as? Int {
        
        cell.totalPrize.text = "$ \(totalPrize)"
        }
        
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
        
        
        var details : NSDictionary
        var source : NSDictionary
        
      var destinationVC : ChallengeDetailsVC = segue.destinationViewController as ChallengeDetailsVC
     
        
        
        if (self.searchDisplayController?.active == true) {
        
            let indexPath : NSIndexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
            details = self.searchResult[indexPath.row] as NSDictionary
            
        }
        else{
            let indexPath :NSIndexPath  = self.tableView.indexPathForSelectedRow()!
            details = realWorldChallenges[indexPath.row] as NSDictionary
        
        }
        
        
        source = details.objectForKey("_source") as NSDictionary
        
        
       var challengeID = details.objectForKey("_id") as NSString
        
    destinationVC.challengeID = challengeID
        
        
        
    }

    
    
    func getRealWorldChallenges() {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET,serviceEndPoint, encoding : .JSON).responseJSON{(request,response,JSON,error) in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if error == nil {
            
                if response?.statusCode == 200 {
                    
                    self.realWorldChallenges = JSON as [NSDictionary]
                
                }
                else{
                
                    var alert  = UIAlertView(title:"Error" , message:"Sorry! error in details loading. " , delegate:self, cancelButtonTitle:"Dismiss")
                    alert.show()
                    println(response?.statusCode)

                
                }
            
            }
            else{
                
                var alert  = UIAlertView(title:"Error" , message:"Sorry! error in details loading. " , delegate:self, cancelButtonTitle:"Dismiss")
                alert.show()
                println(error)

            
            }
            
            
        }
    
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 241.0
    }
    
    
    
    @IBAction func refreshTableView(sender: AnyObject) {
        
        
        getRealWorldChallenges()
        self.refreshControl?.endRefreshing()
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.searchResult = self.realWorldChallenges.filter({( challenge: NSDictionary) -> Bool in
           
            let source = challenge.objectForKey("_source") as NSDictionary
            let challangeName = source.objectForKey("challengeName") as NSString
            
            let stringMatch = challangeName.rangeOfString(searchText)
            return  (stringMatch.length != 0) && true
        })
    }
    
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }

}
