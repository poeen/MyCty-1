//
//  ViewController.swift
//  MyCty
//
//  Created by Brandon Ellis and Umer Khan on 3/6/17.
//  Copyright © 2017 Brandon Ellis , Umer Khan. All rights reserved.
//


//var usernameTxtField: UITextField!
//var passwordTxtField: UITextField!
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth



var ref:FIRDatabaseReference?


class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate {
    @IBOutlet weak var back: UIButton!
    
    var username = ""
    var email = ""
    var phonenumber = ""
    var password = ""
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var finishBtnlbl: UIButton!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var retypePassTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    
    var ref:FIRDatabaseReference?
    var handle:FIRDatabaseHandle?
    
    @IBAction func termsButton(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "termsView")
        present(vc, animated: true, completion: nil)
    
    }
   
    @IBAction func backBtn(_ sender: Any) {
        performSegue(withIdentifier: "Back", sender: self)
    
    }
 
    
    @IBAction func finishBtn(_ sender: Any) {
 
        ref = FIRDatabase.database().reference()
        var handle:FIRDatabaseHandle?
 
        if emailTxtField.text == "" || passwordTxtField.text == "" || retypePassTxtField.text == "" || phoneNumberTxtField.text == "" || usernameTxtField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please complete all the fields", preferredStyle: .alert)
 
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
        if passwordTxtField.text != retypePassTxtField.text {
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
        func handleRegister(){
            guard let _ = emailTxtField.text, let _ = passwordTxtField.text else{
                print("form is not valid")
                return
            }
        }
        
        if phoneNumberTxtField.text!.characters.count != 10  {
            let alertController = UIAlertController(title: "Error", message: "Please enter a 10 digit phone number starting with area code", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)

        }
        
    if usernameTxtField.text != "" && emailTxtField.text != "" && passwordTxtField.text != "" && retypePassTxtField.text != "" && phoneNumberTxtField.text != "" && passwordTxtField.text == retypePassTxtField.text{
        
        username = self.usernameTxtField.text!
        password = self.passwordTxtField.text!
        email = self.emailTxtField.text!
        phonenumber = self.phoneNumberTxtField.text!
        
        
        let rootRef = FIRDatabase.database().reference()
         rootRef.child("Users").queryOrdered(byChild: "Username").queryEqual(toValue: usernameTxtField.text!).observeSingleEvent(of: .value, with: { (snap) in
            
            if snap.exists(){
                            let alertController = UIAlertController(title: "Error", message: "Username Already in use", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                FIRAuth.auth()?.createUser(withEmail: self.email, password: self.password) { (user: FIRUser?, error) in
                
                    if error == nil {
                     
                    }
                    else{
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                    
                    guard let uid = user?.uid else {
                        return
                    }
                    
                    let imageName = NSUUID().uuidString
                    let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
                    
                    if let uploadData = UIImagePNGRepresentation(self.profilePic.image!) {
                        storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                            
                            if error != nil {
                                print(error!)
                                return
                            }
                            
                            if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                                
                                  let ref = FIRDatabase.database().reference(fromURL: "https://mycty-1.firebaseio.com/")
                                let values = ["Username" : self.username, "Email": self.email, "Password" :self.password, "Phone Number": self.phonenumber, "profileImageUrl": profileImageUrl]
                              
                                let userReference = ref.child("Users").child(uid)
                                userReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                                    if err != nil {
                                        print (err!)
                                        return
                                    }
                                
                                })
                                
                            }
                        })
                    }
                    let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MainToTab")
                    self.present(vc, animated: true, completion: nil)

                }
            }
        })
        }
    }
    
    
       @IBAction func uploadProfilePic(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
        
        
        
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            profilePic.image = image
            
        }
            
        else{
            //Error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
        func configureGradientBackground(colors:CGColor...){
        
        let gradient: CAGradientLayer = CAGradientLayer()
        let squareFrame = CGRect(origin: self.view.bounds.origin, size: CGSize(width: 600, height: 1000))
        gradient.frame = squareFrame
        
        gradient.colors = colors
        view.layer.insertSublayer(gradient, at: 0)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        if textField == usernameTxtField{
            self.emailTxtField.becomeFirstResponder()
        }
        else if textField == emailTxtField{
            self.passwordTxtField.becomeFirstResponder()
        
        }
        else if textField == passwordTxtField{
            self.retypePassTxtField.becomeFirstResponder()
        }
        else if textField == retypePassTxtField{
            self.phoneNumberTxtField.becomeFirstResponder()
        }
        return true
    }    
       override func viewDidLoad() {
        finishBtnlbl.layer.cornerRadius = 20
       usernameTxtField.layer.cornerRadius = 20
        emailTxtField.layer.cornerRadius = 20
        passwordTxtField.layer.cornerRadius = 20
        retypePassTxtField.layer.cornerRadius = 20
        phoneNumberTxtField.layer.cornerRadius = 20
        
        
        //Round profile picture
        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.clipsToBounds = true
       
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    // Do any additional setup after loading the view, typically from a nib.
    
        // Do any additional setup after loading the view, typically from a nib.
    }


    
  
 




