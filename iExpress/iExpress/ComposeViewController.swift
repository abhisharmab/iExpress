//
//  ComposeViewController.swift
//  iExpress
//
//  Created by Abhishek Sharma on 10/3/14.
//  Copyright (c) 2014 iExpress. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var sweetTextView: UITextView! = UITextView()
    
    let MAXLENGTH = 140;
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        sweetTextView.layer.borderWidth = 0.5
        sweetTextView.layer.cornerRadius = 5
        
        sweetTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendSweet(sender: AnyObject) {
        //Add code here
        
        var internal_tweets: PFObject = PFObject(className: "TweetsInternal")
        
        if sweetTextView.text.isEmpty
        {
            sweetTextView.text = "Got your message!!"
            internal_tweets["content"] = sweetTextView.text
        }
            
        else
        {
            internal_tweets["content"] = sweetTextView.text
        }
        
        var userName:String = "NewAnonymousUser"
        if PFUser.currentUser() != nil{
            userName = PFUser.currentUser().username
        }

        internal_tweets["sender"] = userName
        internal_tweets.saveInBackground()
        
        /*
        internal_tweets.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if (success != nil) {
                NSLog("Object created")
            } else {
                NSLog("%@", error)
            }
        }*/
        
        var push:PFPush = PFPush()
        push.setChannel("global")
        
        
        var data:NSDictionary = ["alert":PFUser.currentUser().username + ": " + sweetTextView.text, "badge":"0","sound":"chime","title":PFUser.currentUser().username]
        push.setData(data)
        push.sendPushInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
