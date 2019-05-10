//
//  ChecklistAddTagVC.swift
//
//  Created by Florentin Lupascu on 02/04/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

protocol ChecklistAddTagVCDelegate {
    func receiveAddedTags(tags: [Int: Tag])
}

class ChecklistAddTagVC: UIViewController {
    
    // Interface Links
    @IBOutlet weak var tagsTableView: UITableView!
    
    // Properties
    var tagsDictionary: [Int: Tag] = [:]
    var addedTags: [Int: Tag] = [:]
    var delegate: ChecklistAddTagVCDelegate?
    var indexPathForBtn: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsTableView.tableFooterView = UIView()
        
        tagsDictionary = [
            1: Tag(remoteID: 1, categoryID: 1, name: "Tag1", color: "red"),
            2: Tag(remoteID: 2, categoryID: 1, name: "Tag2", color: "blue"),
            3: Tag(remoteID: 3, categoryID: 1, name: "Tag3", color: "orange"),
            4: Tag(remoteID: 4, categoryID: 1, name: "Tag4", color: "black")
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Added tags: \(addedTags.map {$1.name})")
        
        setupButtons()
        
        tagsTableView.reloadData()
    }
}

extension ChecklistAddTagVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagsDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defectAndDamageTagCell", for: indexPath) as! ChecklistAddTagCell
        cell.configCell()
        cell.delegate = self
        cell.tagNameLabel.text = tagsDictionary[indexPath.row + 1]?.name.capitalized
        indexPathForBtn = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}

extension ChecklistAddTagVC: ChecklistAddTagCellDelegate{
    
    // When the user press Add Tag then will be added in a dictionary and sent to ChecklistVC using a callback closure.
    func addTagBtnPressed(button: UIButton, tagLabel: UILabel) {
        
        let buttonPosition: CGPoint = button.convert(CGPoint.zero, to: tagsTableView)
        let indexPath = tagsTableView.indexPathForRow(at: buttonPosition)
        let indexPathForBtn: Int = indexPath?.row ?? 0
        let tag: Tag = tagsDictionary[indexPathForBtn + 1] ?? Tag(remoteID: 0, categoryID: 0, name: String(), color: String())
        
        if button.currentTitle == "+"{
            button.setTitle("-", for: UIControl.State.normal)
            tagLabel.textColor = UIColor.orange
            
            // Add selected tag to Dictionary when the user press +
            addedTags[tag.remoteID] = tag
        }
        else{
            button.setTitle("+", for: UIControl.State.normal)
            tagLabel.textColor = UIColor.black
            
            // Delete selected tag from Dictionary when the user press -
            addedTags.removeValue(forKey: tag.remoteID)
        }
        // Send the Dictionary to ChecklistVC
        if delegate != nil{
            delegate?.receiveAddedTags(tags: addedTags)
        }
        print("\n ****** UPDATED DICTIONARY ******")
        print(addedTags.map {"key: \($1.remoteID) - name: \($1.name)"})
    }
    
    // Setup the state of the buttons and also the color of the buttons to be orange if that Tag exist in `addedTags` dictionary.
    func setupButtons(){
        
        for eachAddedTag in addedTags {
            
            if eachAddedTag.value.remoteID == tagsDictionary[1]?.remoteID {
                
                print(eachAddedTag)
            }
        }
    }
}
