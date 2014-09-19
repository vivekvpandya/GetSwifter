//
//  RealWorldChallengeTVC.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/18/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit

class RealWorldChallengeTVC: UITableViewController {

    
     // An array to hold JSON dictionaries retrived from http://tc-search.herokuapp.com/challenges/v2/search?q=challengeName:realworldswift%20AND%20-status:(Completed%20OR%20Cancelled%20-%20Failed%20Screening)
    
    var realWorldChallenges  :  NSArray?{
        set{

            self.tableView.reloadData()
        }
        get{
            return self.realWorldChallenges
        }
    }
    
    let serviceEndPoint = "http://tc-search.herokuapp.com/challenges/v2/search?q=challengeName:realworldswift%20AND%20-status:(Completed%20OR%20Cancelled%20-%20Failed%20Screening)"
    
    
     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       /* var numberOfRows = 0
        
        if realWorldChallenges != nil{
            numberOfRows = self.realWorldChallenges.count }
        
            return numberOfRows */
        
     return realWorldChallenges.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("realWorldChallenge")! as UITableViewCell
        
        cell.textLabel?.text = realWorldChallenges[indexPath.row].objectForKey("challengeName") as? String
        
    
        
        
        return cell
        
        
    }

    func  getRealWorldChallenges(){
        
        var config :NSURLSessionConfiguration  = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session : NSURLSession = NSURLSession(configuration: config)
        
        
        var request : NSMutableURLRequest = NSMutableURLRequest(URL:NSURL(string:serviceEndPoint))
        
        
        session.dataTaskWithRequest(request, completionHandler: { (data:NSData!, response:NSURLResponse!, error:NSError!) -> Void in
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
                
                var jsonError : NSError?
                
                //  var documents : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error:&jsonError) as NSDictionary
                
                
                self.realWorldChallenges = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error:&jsonError) as Array
                
                 println(self.realWorldChallenges)
                
                println(error)
                println(jsonError)

            })
            
            
        }).resume()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
  
    }
    
    override func viewDidLoad() {
        self.getRealWorldChallenges()
    }
    
}
