//
//  ChecklistItem.swift
//  AppendCommentsToCells
//
//  Created by Florentin Lupascu on 07/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import Foundation
import UIKit

class ChecklistItem: NSObject, NSCoding {

    var template_id: Int
    var line_id: Int
    var descript: String

    var vehicleComment: String = String()
    var trailerComment: String = String()

    init?(templateID: Int,
          lineID: Int,
          descript: String // Question name
        ) {
        
        self.template_id = templateID
        self.line_id = lineID
        self.descript = descript
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.template_id, forKey: "template_id")
        aCoder.encode(self.line_id, forKey: "line_id")
        aCoder.encode(self.descript, forKey: "descript")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.template_id = aDecoder.decodeObject(forKey: "template_id") as! Int
        self.line_id = aDecoder.decodeObject(forKey: "line_id") as! Int
        self.descript = aDecoder.decodeObject(forKey: "descript") as! String
    }
}
