//
//  createAgenda.swift
//  MyCty
//
//  Created by Umer Khan on 3/23/17.
//  Copyright © 2017 Umer Khan. All rights reserved.
//

import UIKit

class AgendaDetailVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBAction func createAgenda(_ sender: Any) {
        
              
        
    if categoryTextField.text != "" && descriptionField.text != "" && timeTextField.text != "" && dateTextField.text != "" {
      
      //  agenda.removeAll(keepingCapacity: true)
        
       agenda[0] = categoryTextField.text!
        agenda[1] = descriptionField.text!
        agenda[2] = timeTextField.text!
        agenda[3] = dateTextField.text!
        
        
        
        
        
        
        
        }
        
    /*   agenda.insert(categoryTextField.text!, at: 0)
        agenda.insert(descriptionField.text!, at: 1)
        agenda.insert(timeTextField.text!, at: 2)
        agenda.insert(dateTextField.text!, at: 3)
       */
                
        
        /*
        
        
        if (categoryTextField.text != "")
        {
           agenda[0] = categoryTextField.text!
            //categoryTextField.text = ""
            agenda.append(categoryTextField.text!)
        }
        
        if (descriptionField.text != "")
        {
            agenda[1] = descriptionField.text!
            
            //categoryTextField.text = ""
        }

        if (timeTextField.text != "")
        {
            agenda[2] = timeTextField.text!
            agenda.append(timeTextField.text!)
            //categoryTextField.text = ""
        }

        if (dateTextField.text != "")
        {
            agenda[3] = dateTextField.text!
            
        }
 

        */
        
    self.performSegue(withIdentifier: "backToLand", sender: self)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
              // Do any additional setup after loading the view, typically from a nib.
        
        
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
    
    
}








    

