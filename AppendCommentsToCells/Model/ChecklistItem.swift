//
//  ChecklistItem.swift
//  AppendCommentsToCells
//
//  Created by Florentin Lupascu on 07/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import Foundation

class ChecklistItem {

    var template_id: Int
    var line_id: Int
    var descript: String

    var vehicleComment = String()
    var trailerComment = String()
    var vehicleTags: [Int: Tag] = [:]
    var trailerTags: [Int: Tag] = [:]

    init?(templateID: Int,
          lineID: Int,
          descript: String // Question name
        ) {
        
        self.template_id = templateID
        self.line_id = lineID
        self.descript = descript
    }
}
