//
//  ProfileView.swift
//  MyCty
//
//  Created by Umer Khan on 4/21/17.
//  Copyright © 2017 Umer Khan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ProfileVC: UIViewController{
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    func getFacebookUserInfo() {
        if(FBSDKAccessToken.current() != nil)
        {
            //print permissions, such as public_profile
            print(FBSDKAccessToken.current().permissions)
            let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
            let connection = FBSDKGraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                
                self.profileName.text = data["name"] as? String
                
                let FBid = data["id"] as? String
                
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                self.profilePic.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
            })
            connection.start()
        }
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFacebookUserInfo()
        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.clipsToBounds = true

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
            }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
}
