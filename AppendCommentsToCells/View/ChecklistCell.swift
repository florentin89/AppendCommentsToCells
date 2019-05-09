//
//  ChecklistCell.swift
//  AppendCommentsToCells
//
//  Created by Florentin Lupascu on 07/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

protocol ChecklistCellDelegate {
    func tapGestureOnCell(_ cell: ChecklistCell)
}

class ChecklistCell: UITableViewCell {

    // Interface Links
    @IBOutlet weak var questionName: UILabel!
    @IBOutlet weak var vehicleCommentLabel: UILabel!
    @IBOutlet weak var trailerCommentLabel: UILabel!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    var delegate: ChecklistCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.tapEdit(sender:)))
        addGestureRecognizer(longTapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // Detect when the user press Long Tap on any cell
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        delegate?.tapGestureOnCell(self)
    }

    // Config the cell for Defect and Damage Check
    func configCell(_ checklistItem: ChecklistItem){
    
        questionName.text = checklistItem.descript
        vehicleCommentLabel.text = checklistItem.vehicleComment
        trailerCommentLabel.text = checklistItem.trailerComment
    }
}
