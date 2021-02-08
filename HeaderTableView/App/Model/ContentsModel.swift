//
//  ContentsModel.swift
//  HeaderTableView
//
//  Created by K12 Services on 08/02/21.
//

import Foundation
class ContentsModel {
    var city : String?
    var weather : String?
    var hourly_temp : [Hourly_temp]?
    
    public init?(json: JSON) {
        city = json["city"] as? String
        weather = json["weather"] as? String
        
        var list = [Hourly_temp]()
        for dictionary in (json["hourly_temp"] as? NSArray)! {
            guard let list_items = Hourly_temp(json: dictionary as! JSON) else { continue }
            list.append(list_items)
        }
        hourly_temp = list
    }
}


class Hourly_temp {
    var temp : Double?
    var hour : Double?
    public init?(json: JSON) {
        temp = json["temp"] as? Double
        hour = json["hour"] as? Double
    }
}
