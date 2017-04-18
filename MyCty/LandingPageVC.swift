//
//  LandingPageVC.swift
//  MyCty
//
//  Created by Umer Khan on 3/22/17.
//  Copyright © 2017 Umer Khan. All rights reserved.
//


import UIKit
import Firebase
import SwiftKeychainWrapper

class LandingPageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Variables & Oulets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var myTableView: UITableView!
    //var testingKey = "237895837hfjskdlfjkld3" //only used for testing - need user key
    var agendas = [Agenda]()
    var selectedCell = "" as AnyObject
    var menuShowing = false

    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    
    @IBAction func openMenu(_ sender: Any) {
        
        if (menuShowing){
            leadingConstraint.constant = 0
            
        } else{
            leadingConstraint.constant = 180
        }
        menuShowing = !menuShowing
    }
    
 
    @IBAction func switchToCreate(_ sender: Any) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AgendaDetailVC")
        self.present(vc, animated: true, completion: nil)
    }
   
    
    
    
    
    
    //TODO: Setup user in Userdefaults or keychain to be used in Firebase query
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self

            
        navBar.barTintColor = UIColor(red: 132.0/255.0, green: 36.0/255.0, blue: 42.0/255.0, alpha: 1.0)
        
        //retrieve Firebase Data
        DataService.ds.Ref_Agendas.observe(.value, with: { (snapshot) in
            self.agendas = []
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    //print(snap)
                    if let agendasDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let post = Agenda(key: key, data: agendasDict)
                        //if let data = agendasDict[self.testingKey] as? Dictionary<String,AnyObject> {
                        self.agendas.append(post)
                        
                        }
                    }
                }
            self.myTableView.reloadData()
            }
        )}
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return agendas.count - 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let agenda = agendas[indexPath.row]
        
        if let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomTableViewCell {
            cell.configureCell(agendaData: agenda)
            return cell
        } else {
            return MyCustomTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Preview", sender: indexPath)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rowIndex: NSIndexPath = myTableView.indexPathForSelectedRow! as NSIndexPath
        let selectedRow: MyCustomTableViewCell = myTableView.cellForRow(at: rowIndex as IndexPath)! as! MyCustomTableViewCell
        //let contentFromSelectedRow: String = selectedRow.textLabel!.text!
        
        if let secondVC = segue.destination as? FullAgendaView {
            if segue.identifier == "Preview" {
            secondVC.categoryText = selectedRow.categoryLabel.text
                secondVC.timeText = selectedRow.time.text
            secondVC.descriptionText = selectedRow.descriptionLabel.text
            secondVC.dateText = selectedRow.bigDateLabel.text
    
                
            }
        }
    }



    
    
    
    
        //deletes a table cell
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
           // let agenda = self.agendas[indexPath.row]
            
            agendas.remove(at: indexPath.row)
           
            
            
            
        /*
            DataService.ds.Ref_Agendas.observe(.value, with: { (snapshot) in

        if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
            
            for snap in snapshot{
            let agendasDict = snap.value as? Dictionary<String,AnyObject>
                }
                }
            })
            
           */
          //  DataService.ds.Ref_Agendas.child
            myTableView.reloadData()
            
        }
    }
    
    
    
    @IBAction func signOut(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)//removeObjectForKey
        print("Umer: ID removed from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OpeningView")
        self.present(vc, animated: true, completion: nil)
    }
    

    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.myTableView.separatorStyle = .none
        myTableView.reloadData()
        
    }

    //override var prefersStatusBarHidden: Bool {
     //   return true
   // }
}

