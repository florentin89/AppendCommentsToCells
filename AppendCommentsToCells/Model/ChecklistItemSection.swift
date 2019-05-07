//
//  ChecklistItemSection.swift
//  AppendCommentsToCells
//
//  Created by Florentin Lupascu on 07/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import Foundation

class ChecklistItemSection {
    
    var name: String // name of the section
    var checklistItems: [ChecklistItem] // all items from Checklist
    
    init(named: String, includeChecklistItems: [ChecklistItem]) {
        
        name = named
        checklistItems = includeChecklistItems
    }
    
    class func checklistItemSections() -> [ChecklistItemSection] {
        
        return [vehicleCheck(), viewingScreen(), batteryUnitAndFridge()]
    }
    
    // Private methods
    private class func vehicleCheck() -> ChecklistItemSection {
        
        var checklistItems = [ChecklistItem]()
        
        checklistItems.append(ChecklistItem(templateID: 1, lineID: 1, descript: "Question 1")!)
        checklistItems.append(ChecklistItem(templateID: 2, lineID: 2, descript: "Question 2")!)
        checklistItems.append(ChecklistItem(templateID: 3, lineID: 3, descript: "Question 3")!)
        
        return ChecklistItemSection(named: "Section 1", includeChecklistItems: checklistItems)
    }
    
    private class func viewingScreen() -> ChecklistItemSection {
        
        var checklistItems = [ChecklistItem]()
        
        checklistItems.append(ChecklistItem(templateID: 4, lineID: 4, descript: "Question 4")!)
        checklistItems.append(ChecklistItem(templateID: 5, lineID: 5, descript: "Question 5")!)
        return ChecklistItemSection(named: "Section 2", includeChecklistItems: checklistItems)
    }
    
    private class func batteryUnitAndFridge() -> ChecklistItemSection {
        
        var checklistItems = [ChecklistItem]()
        
        checklistItems.append(ChecklistItem(templateID: 6, lineID: 6, descript: "Question 6")!)
        checklistItems.append(ChecklistItem(templateID: 7, lineID: 7, descript: "Question 7")!)
        checklistItems.append(ChecklistItem(templateID: 8, lineID: 8, descript: "Question 8")!)
        checklistItems.append(ChecklistItem(templateID: 9, lineID: 9, descript: "Question 9")!)
        return ChecklistItemSection(named: "Section 3", includeChecklistItems: checklistItems)
    }
}
