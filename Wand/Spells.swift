//
//  Spells.swift
//  Wand
//
//  Created by Ella Gryf-Lowczowska on 20/06/2019.
//  Copyright © 2019 Ella Gryf-Lowczowska. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Spells {
    struct SpellData {
        var name = ""
        var url = ""
    }
    
    var spellData: [SpellData] = []
    var apiURL = "https://potterspells.herokuapp.com/api/v1/spells"
    
    func getSpells(completed: @escaping ()->() ) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let numberOfSpells = json["results"].count
                for index in 0..<numberOfSpells {
                    let name = json["results"][index]["name"].stringValue
                    let url = json["results"][index]["url"].stringValue
                    self.spellData.append(SpellData(name: name, url: url))
                    print("\(index).\(name)\(url)")
                }
            case .failure(let error):
                print("ERROR: \(error) failed to get data from url \(self.apiURL)")
            }
            completed()
        }
    }
}





