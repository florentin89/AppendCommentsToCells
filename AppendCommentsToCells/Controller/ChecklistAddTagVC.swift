//
//  ChecklistAddTagVC.swift
//
//  Created by Florentin Lupascu on 02/04/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

class ChecklistAddTagVC: UIViewController {
    
    // Interface Links
    @IBOutlet weak var tagsTitleLabel: UILabel!
    @IBOutlet weak var tagsTableView: UITableView!
    
    // Properties
    var tagsDictionary: [Int: Tag] = [:]
    var tagsAdded: [Int:Tag] = [:]
    var tagsCallback: (([Int:Tag]) -> ())?
    var indexForSelectedRow: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsTableView.tableFooterView = UIView()
        
        tagsDictionary = [
            1: Tag(remoteID: 1, categoryID: 1, name: "Tag1", colour: "red"),
            2: Tag(remoteID: 2, categoryID: 1, name: "Tag2", colour: "blue"),
            3: Tag(remoteID: 3, categoryID: 1, name: "Tag3", colour: "orange"),
            4: Tag(remoteID: 4, categoryID: 1, name: "Tag4", colour: "black")
        ]
        
        print("Received index for SelectedRow: \(indexForSelectedRow ?? IndexPath())")
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}

extension ChecklistAddTagVC: ChecklistAddTagCellDelegate{
   
    // When the user press Add Tag then will be added in a dictionary and sent to ChecklistVC using a callback closure.
    func addTagBtnPressed(button: UIButton, tagLabel: UILabel) {
        
        if button.currentTitle == "+"{
            button.setTitle("-", for: UIControl.State.normal)
            tagLabel.textColor = UIColor.orange
            tagsAdded = [0: Tag(remoteID: 1, categoryID: 1, name: tagLabel.text ?? String(), colour: "red")]
            print(tagsAdded[0]?.name ?? String())
            tagsCallback?(tagsAdded)
        }
        else{
            button.setTitle("+", for: UIControl.State.normal)
            tagLabel.textColor = UIColor.black
            tagsAdded.removeValue(forKey: 0)
            print(tagsAdded)
            tagsCallback?(tagsAdded)
        }
    }
}
