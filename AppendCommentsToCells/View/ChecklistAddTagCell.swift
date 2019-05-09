//
//  ChecklistAddTagCell.swift
//
//  Created by Florentin Lupascu on 02/04/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

protocol ChecklistAddTagCellDelegate {
    func addTagBtnPressed(button: UIButton, tagLabel: UILabel)
}

class ChecklistAddTagCell: UITableViewCell {

    // Interface Links
    @IBOutlet weak var tagNameLabel: UILabel!
    @IBOutlet weak var addTagBtnOutlet: UIButton!
    
    // Properties
    var delegate: ChecklistAddTagCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configCell(){
        
        addTagBtnOutlet.layer.cornerRadius = 5
        addTagBtnOutlet.layer.borderColor = UIColor.black.cgColor
        addTagBtnOutlet.layer.borderWidth = 0.5
    }

    @IBAction func addTagBtnTapped(_ sender: UIButton) {
        
        delegate?.addTagBtnPressed(button: sender, tagLabel: tagNameLabel)
    }
}
