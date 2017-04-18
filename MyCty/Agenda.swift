//
//  Agenda.swift
//  MyCty
//
//  Created by Umer Khan on 3/21/17.
//  Copyright © 2017 Umer Khan. All rights reserved.
//


class Agenda {
    
    //TODO: change back to unwrapped (!) once backend is setup
    private var _category: String?
    private var _location: String?
    private var _time: String?
    private var _event: String?
    private var _cost: String?
    private var _details: String?
    private var _date:String?
    private var _description:String?
    private var _newagenda: String?
    private var _userKey:String?
    private var _premium:Bool?
    private var _rating:Int?
    
    
    var category: String? {
        return _category?.capitalized
    }
    
    var location: String? {
        return _location
    }
    
    var time: String? {
        return _time
    }
    
    var event: String? {
        return _event
    }
    var cost: String? {
        return _cost
    }
    
    var details: String? {
        return _details
    }

    var date: String? {
        return _date
    }
    
    var description: String? {
        return _description
    }
    
    var userKey:String? {
        return _userKey
    }
    
    var premium:Bool? {
        return _premium
    }
    
    var rating:Int? {
        return _rating
    }
    
    init(date: String, category: String, time: String, description: String, rating: Int){
        self._date = date
        self._category = category
        self._time = time
        self._description = description
        self._rating = rating
    }
    
    init(key:String, data:Dictionary<String,AnyObject>) {
        _userKey = key
        
        if let categoryData =  data["category"] as? String {
            _category = categoryData
        }
        
        if let addressData = data["address"] as? String {
            _location = addressData
        }
        
        if let premiumData = data["premium"] as? Bool {
            _premium = premiumData
        }
    
        if let ratingData = data["rating"] as? Int {
            _rating = ratingData
        }
        
        if let timeData = data["time"] as? String {
            _time = timeData
        }
        
        if let dateData = data["date"] as? String {
            _date = dateData
        }
        
        if let descriptionData = data["description"] as? String {
            _description = descriptionData
        }
        
        if let costData = data["cost"] as? String {
            _cost = costData
        }
        
        if let eventData = data["event"] as? String {
            _event = eventData
        }
        
    }
}
