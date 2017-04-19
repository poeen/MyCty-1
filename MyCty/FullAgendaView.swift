//
//  FullAgendaView.swift
//  MyCty
//
//  Created by Umer Khan on 4/12/17.
//  Copyright © 2017 Umer Khan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FullAgendaView: UIViewController{
    
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var detailsBox: UILabel!
    @IBOutlet weak var cost: UILabel!
    
    @IBOutlet weak var event: UILabel!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rating: RatingControl!
   
    @IBOutlet weak var barView: UIView!
    
    var categoryText :String?
    var handle :FIRDatabaseHandle?
    var agenda: Agenda!
    var timeText: String?
    var dateText: String?
    var descriptionText: String?
    var detailsText: String?
    var costText: String?
    var eventText: String?
    var addressText: String?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        category.text = categoryText
        time.text = timeText
        date.text = dateText
        detailsBox.text = detailsText
        cost.text = costText
        event.text = eventText
        address.text = addressText
        
        barView.tintColor = UIColor(red: 132.0/255.0, green: 36.0/255.0, blue: 42.0/255.0, alpha: 1.0)

           }
    
}
