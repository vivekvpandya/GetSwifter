//
//  CompletedChallengeVC.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit

import Alamofire

class CompletedChallengeVC: UITableViewController,UIAlertViewDelegate{
    
    
    // URL to get details in JSON format
    let serviceEndPoint = "http://tc-search.herokuapp.com/challenges/v2/search?q=technologies:Swift%20AND%20status:Completed"
    
    var completedChallenges :[NSDictionary] = [] {
        
        didSet{
            
            
            self.tableView!.reloadData()
        }
        
        
    }
    
    var searchResult : [NSDictionary] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getCompletedChallenges()
        
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
        return completedChallenges.count
        }
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        
        
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("completedChallenge", forIndexPath: indexPath!) as CompletedChallengeTableViewCell
        
        
        var dateFormater : NSDateFormatter = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        dateFormater.timeZone = NSTimeZone(name:"GMT")
        
        var opDateFormater : NSDateFormatter = NSDateFormatter()
        opDateFormater.timeZone = NSTimeZone(name:"GMT")
        opDateFormater.dateStyle=NSDateFormatterStyle.MediumStyle
        opDateFormater.timeStyle = NSDateFormatterStyle.LongStyle
        
        
        
        var details : NSDictionary
        var source : NSDictionary
        
        if tableView == self.searchDisplayController?.searchResultsTableView{
            details = searchResult[indexPath!.row] as NSDictionary
        }
        else{
            details = completedChallenges[indexPath!.row] as NSDictionary
            
            
        }
        
     
         source = details.objectForKey("_source") as NSDictionary
        
        if let challengeTitle = source.objectForKey("challengeName") as? NSString {
        
            cell.challengeTitle.text = challengeTitle
        }
        
        if let numSubmission = source.objectForKey("numSubmission") as? Int {
        cell.numSubmissionLabel.text = "\(numSubmission)"
        
        }
        
        if let numRegistrants = source.objectForKey("numSubmissions") as? Int {
        
            
            cell.registrantsLabel.text = "\(numRegistrants)"
        }
        
        if let totalPrize = source.objectForKey("totalPrize") as? Int {
        
        cell.totalPrizeLabel.text = " $ \(totalPrize)"
        }
        
        if let technologyArray = source.objectForKey("technologies") as? NSArray {
        cell.technologyLabel.text = technologyArray.componentsJoinedByString(",")
        }
        
        if let platformArray = source.objectForKey("platforms") as? NSArray {
        cell.platformlLabel.text = platformArray.componentsJoinedByString(",")
        }
        
        
        if let subEndDate = source.objectForKey("submissionEndDate") as? NSString {
        
            let subEndDate = dateFormater.dateFromString(subEndDate)
            let subEndDateString = opDateFormater.stringFromDate(subEndDate!)
            cell.subEndDateLabel.text = subEndDateString
        }
        
       /* var challengeTitle : NSString = ""
        challengeTitle = (source.objectForKey("challengeName") as NSString)
        
        cell.challengeTitle.text = challengeTitle
  
        var numSubmissions:Int? = 0
        numSubmissions = (source.objectForKey("numSubmissions") as Int)
        cell.numSubmissionLabel.text = "Submissions: \(numSubmissions)"
        var numRegistrants:Int? = 0
       numRegistrants = ( source.objectForKey("numRegistrants") as Int)
        cell.registrantsLabel.text = "Registrants: \(numRegistrants)"
        var totalPrize:Int? = 0
       totalPrize = (source.objectForKey("totalPrize") as Int)
       cell.totalPrizeLabel.text = "Total Prize: $ \(totalPrize) "
       
        var technologiesArray : NSArray = []
        technologiesArray = source.objectForKey("technologies") as NSArray
        
        var technologies:NSString = (technologiesArray).componentsJoinedByString(",")
        cell.technologyLabel.text = "Technologies: \(technologies)"
        
        var platformsArray = []
       platformsArray =  source.objectForKey("platforms") as NSArray
        
        var platforms : NSString = (platformsArray).componentsJoinedByString(",")
        cell.platformlLabel.text = "Platforms: \(platforms)"
        
        
        
        
        var subEndDate:NSDate? = dateFormater.dateFromString( source.objectForKey("submissionEndDate") as NSString)
        
      
        
        let subEndDateString = opDateFormater.stringFromDate(subEndDate!) as NSString
        
        cell.subEndDateLabel.text = "Submission Ended: \(subEndDateString) "
        
        */
        
        
        
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
  /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        
        // Get the new view controller using [segue destinationViewController].
        
        var destinationVC : RealWorldChallengeDetailsVC = segue.destinationViewController as RealWorldChallengeDetailsVC
        
        let indexPath :NSIndexPath  = self.tableView.indexPathForCell(sender as UITableViewCell)!
        
        var details = completedChallenges[indexPath.row] as NSDictionary
        var source = details.objectForKey("_source") as NSDictionary
        
        
        destinationVC.challengeID = details.objectForKey("_id") as NSString
        
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func getCompletedChallenges() {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET,serviceEndPoint, encoding : .JSON).responseJSON{(request,response,JSON,error) in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if error == nil {
                
                if response?.statusCode == 200 {
                    
                    self.completedChallenges = JSON as [NSDictionary]
                    
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
    
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 208.0
    }
    
    
    @IBAction func refreshTableView(sender: AnyObject) {
        
        
        getCompletedChallenges()
        self.refreshControl?.endRefreshing()
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.searchResult = self.completedChallenges.filter({( challenge: NSDictionary) -> Bool in
            
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
