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
            sweetTextView.text = "On my way!"
        }
            
        else
        {
            internal_tweets["content"] = sweetTextView.text
        }
        
        
        internal_tweets["sender"] = "suzzane" //PFUser.currentUser() Change this later on to PFUser.CurrentUser()
        internal_tweets.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if (success != nil) {
                NSLog("Object created")
            } else {
                NSLog("%@", error)
            }
        }
        
        var push:PFPush = PFPush()
        push.setChannel("global")
        

        
        var data:NSDictionary = ["alert":sweetTextView.text, "badge":"0", "sound":"."]
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
