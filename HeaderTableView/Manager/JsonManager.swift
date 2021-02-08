//
//  JsonManager.swift
//  HeaderTableView
//
//  Created by K12 Services on 08/02/21.
//

import Foundation

class JsonManager: NSObject {
    
    static let sharedInstance = JsonManager()
func getSideMenuItemResponse(onSuccess: @escaping([Any]?) -> ())
{
    do {
        if let file = Bundle.main.url(forResource: "Contents", withExtension: "json") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                // json is a dictionary
                let projectResult = object["contents"] as! NSArray
                print(object)
                onSuccess(projectResult as? [Any])
                
            } else if let object = json as? [Any] {
                // json is an array
                print(object)
                onSuccess(object)
            } else {
                print("JSON is invalid")
            }
        } else {
            print("no file")
        }
    } catch {
        print(error.localizedDescription)
    }
}
}
