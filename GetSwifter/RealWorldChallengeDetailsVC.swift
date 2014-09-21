//
//  RealWorldChallengeDetailsVC.swift
//  GetSwifter
//
//  Created by Vivek Pandya on 9/20/14.
//  Copyright (c) 2014 Vivek Pandya. All rights reserved.
//

import UIKit
import Alamofire
import Social

class RealWorldChallengeDetailsVC: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
 
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var postButton: UIButton!
  
    @IBOutlet weak var detailsWebView: UIWebView!
    
    @IBOutlet weak var tweetButton: UIButton!
    
    var serviceEndPoint : String = "http://api.topcoder.com/v2/develop/challenges/" // here challenge id will be appended at the end
    
    var challengeID : NSString = "" // This value will be set by prepareForSegue method of RealWorldChallengesTVC
    
    var directURL : NSString = "" // this will be used to open topcoder challenge page in Safari
    

    override func viewDidLoad() {
        super.viewDidLoad()
    registerButton.enabled = false
        postButton.enabled = false
        tweetButton.enabled = false
       getChallengeDetails()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func getChallengeDetails(){
    
        activityIndicator.startAnimating()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        var apiURLString = "\(serviceEndPoint)\(challengeID)"
        
      
        
        Alamofire.request(.GET,apiURLString, encoding : .JSON).responseJSON
            { (request,response,JSON,error) in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            if (error == nil){
            
                if response?.statusCode == 200{
                    
                    
            
            self.activityIndicator.stopAnimating()
            var challengeDetails : NSDictionary = JSON as NSDictionary
                    
                    if let directURL = challengeDetails.objectForKey("directUrl") as? NSString {
                    
                        self.directURL = directURL
                        self.registerButton.enabled = true
                        self.tweetButton.enabled = true
                        self.postButton.enabled = true
                    }

                    if let detailedReq = challengeDetails.objectForKey("detailedRequirements") as? NSString{
                        
                        
                        self.detailsWebView.loadHTMLString(detailedReq, baseURL:nil)

                    
                    }
            
                    
            
                    
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

   

    @IBAction func registerForChallenge(sender: AnyObject) {
        
        if self.directURL != ""{
           
        
            var url = NSURL(string: self.directURL)
            UIApplication.sharedApplication().openURL(url)
        
        }
    }
    
    @IBAction func postToFaceBook(sender: AnyObject) {
        
        if self.directURL != "" {
        
    
            
            var socialVC :SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            socialVC.setInitialText("Hey check out this cool swift challenge \(self.directURL)")
            self.presentViewController(socialVC, animated:true, completion:nil)
        }
        
    }
   
   @IBAction func tweetChallengeDetails(sender: AnyObject) {
        
        
        if self.directURL != "" {
            
            var socialVC :SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            socialVC.setInitialText("Hey check out this cool swift challenge \(self.directURL)")
            self.presentViewController(socialVC, animated:true, completion:nil)
        }

        
    }
    
    

    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
