//
//  SwiftLeaderBoardTVC.swift
//  GetSwifter
//

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
        
           }
    
  
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
                return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return leaders.count
    }
    
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        let cell = tableView!.dequeueReusableCellWithIdentifier("swiftLeader", forIndexPath: indexPath!) as SwiftLeaderTableViewCell
        
        
        var details = leaders[indexPath!.row] as NSDictionary
        if let handle = details.objectForKey("handle") as? NSString {
        
          cell.handleLabel.text = handle
        }
      
        if let rank = details.objectForKey("rank") as? Int {
        
            cell.rankLabel.text = "#\(rank)"
        }
        
        if let score = details.objectForKey("score") as? Double {
            cell.scoreLabel.text = "\(score)"
        }
        
        
        if let profileImageURLString =  details.objectForKey("pic") as? NSString{
        
        cell.circularProfileView.image = UIImage(data:NSData(contentsOfURL: NSURL(string: profileImageURLString)))
    }
    
        return cell
    }
    
    
    
        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return false
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
