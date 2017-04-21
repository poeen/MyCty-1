//
//  TableViewCell.swift
//  MyCty
//
//  Created by Umer Khan on 3/22/17.
//  Copyright © 2017 Umer Khan. All rights reserved.
//

import UIKit

class MyCustomTableViewCell: UITableViewCell{

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var bigDateLabel: UILabel!

    @IBOutlet weak var ratings: RatingControl!
    @IBOutlet weak var greenView: UIView!
    var agenda: Agenda!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        greenView.layer.cornerRadius = 10
    }
    
    func configureCell(agendaData:Agenda) {
        self.agenda = agendaData
        categoryLabel.text = agendaData.category
        descriptionLabel.text = agendaData.description
        time.text = agendaData.time
        bigDateLabel.text = agendaData.date
       
        
    }
    
    
}
