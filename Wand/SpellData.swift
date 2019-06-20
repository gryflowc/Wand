//
//  SpellData.swift
//  Wand
//
//  Created by Ella Gryf-Lowczowska on 20/06/2019.
//  Copyright © 2019 Ella Gryf-Lowczowska. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SpellData {
    var name = ""
    var description = ""
    var soundFile = ""
    var apiURL = ""
    
    func getData(completed: @escaping ()->() ) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.description = json["description"].stringValue
                self.soundFile = json["soundFile"].stringValue
            case .failure(let error):
                print("ERROR: \(error) failed to get data from url \(self.apiURL)")
            }
            completed()
        }
    }
    
}


