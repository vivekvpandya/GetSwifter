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

class ChallengeDetailsVC: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
 
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var postButton: UIButton!
  
    @IBOutlet weak var detailsWebView: UIWebView!
    
    @IBOutlet weak var tweetButton: UIButton!
    
    
    
    @IBOutlet weak var firstPlacePrize: UILabel!
    
    @IBOutlet weak var secondPlacePrize: UILabel!
    
    @IBOutlet weak var thirdPlacePrize: UILabel!
    
    @IBOutlet weak var fourthPlacePrize: UILabel!
    
    
    @IBOutlet weak var fifthPlacePrize: UILabel!
    
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
                        self.detailsWebView.layer.borderColor = UIColor.blueColor().CGColor
                        self.detailsWebView.layer.borderWidth = 0.3
                    
                    }
                    
                    if let prize = challengeDetails.objectForKey("prize") as? NSArray {
                    
                    
                        if 1 <= prize.count{
                        if let firstPrize = prize[0] as? Int{
                        self.firstPlacePrize.text = "$ \(firstPrize)"
                        }
                        }
                        if 2 <= prize.count {
                        if let secondPrize = prize[1] as? Int{
                            self.secondPlacePrize.text = "$ \(secondPrize)"
                        }
                        }
                        if 3 <= prize.count {
                        if let thirdPrize = prize[2] as? Int{
                            self.thirdPlacePrize.text = "$ \(thirdPrize)"
                        }
                        }
                        if 4 <= prize.count {
                        if let fourthPrize = prize[3] as? Int{
                            self.fourthPlacePrize.text = "$ \(fourthPrize)"
                        }
                        }
                        if 5 <= prize.count {
                        if let fifthPrize = prize[4] as? Int{
                            self.fifthPlacePrize.text = "$ \(fifthPrize)"
                        }
                        }

                    
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
