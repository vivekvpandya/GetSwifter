//
//  FunChallengeDetailsVC.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit

import Alamofire

class FunChallengeDetailsVC: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var challengeLabel: UILabel!
    
    @IBOutlet weak var regEndDateLabel: UILabel!
    @IBOutlet weak var subEndDateLabel: UILabel!
    @IBOutlet weak var technologyLabel: UILabel!
    
    @IBOutlet weak var detailsWebView: UIWebView!
    
    @IBOutlet weak var platformLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    var serviceEndPoint : String = "http://api.topcoder.com/v2/develop/challenges/" // here challenge id will be appended at the end
    
    var challengeID : NSString = "" // This value will be set by prepareForSegue method of RealWorldChallengesTVC
    
    var directURL : NSString = "" // this will be used to open topcoder challenge page in Safari
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.enabled = false
        getChallengeDetails()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func getChallengeDetails(){
        
        activityIndicator.startAnimating()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var apiURLString = "\(serviceEndPoint)\(challengeID)"
        
        println(apiURLString)
        
        Alamofire.request(.GET,apiURLString, encoding : .JSON).responseJSON
            { (request,response,JSON,error) in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                if (error == nil){
                    
                    if response?.statusCode == 200{
                        
                        
                        
                        self.activityIndicator.stopAnimating()
                        var challengeDetails : NSDictionary = JSON as NSDictionary
                        
                        self.directURL = challengeDetails.objectForKey("directUrl") as NSString
                        println(challengeDetails)
                        self.challengeLabel.text = challengeDetails.objectForKey("challengeName") as NSString
                        self.technologyLabel.text = (challengeDetails.objectForKey("technology") as NSArray).componentsJoinedByString(",")
                        self.platformLabel.text = (challengeDetails.objectForKey("platforms") as NSArray).componentsJoinedByString(",")
                        self.detailsWebView.loadHTMLString(challengeDetails.objectForKey("detailedRequirements") as NSString, baseURL:nil)
                        
                        
                        var dateFormater : NSDateFormatter = NSDateFormatter()
                        dateFormater.dateFormat = "M dd yyyy , hh:mm "
                        dateFormater.timeZone = NSTimeZone(name:"UTC")
                        // var regEnd:NSDate = dateFormater.dateFromString( challengeDetails.objectForKey("registrationEndDate") as NSString!)!
                        
                        //  self.regEndDateLabel.text = dateFormater.stringFromDate(regEnd)
                        
                        self.registerButton.enabled = true
                    }
                    else{
                        
                        self.activityIndicator.stopAnimating()
                        var alert  = UIAlertView(title:"Error" , message:"Sorry! error in details loading. " , delegate:self, cancelButtonTitle:"Dismiss")
                        
                        alert.show()
                        
                    }
                    
                }
                else{
                    self.activityIndicator.stopAnimating()
                    var alert  = UIAlertView(title:"Error" , message:"Sorry! error in details loading. " , delegate:self, cancelButtonTitle:"Dismiss")
                    alert.show()
                }
        }
        
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func registerForChallenge(sender: AnyObject) {
        
        if self.directURL != ""{
            println("in")
            
            var url = NSURL(string: self.directURL)
            UIApplication.sharedApplication().openURL(url)
            
        }
    }
    
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
