//
//  ViewController.swift
//  AppendCommentsToCells
//
//  Created by Florentin Lupascu on 07/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

class ChecklistVC: UIViewController {

    @IBOutlet weak var questionsTableView: UITableView!
    
    //Properties
    lazy var itemSections: [ChecklistItemSection] = {
        return ChecklistItemSection.checklistItemSections()
    }()
    var lastIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        questionsTableView.reloadData()
    }
}

extension ChecklistVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let itemCategory = itemSections[section]
        return itemCategory.checklistItems.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return itemSections.count
    }
    
    // Set the header of each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let checklistItemCategory = itemSections[section]
        return checklistItemCategory.name.uppercased()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checklistCell", for: indexPath) as! ChecklistCell
        
        let itemCategory = itemSections[indexPath.section]
        let item = itemCategory.checklistItems[indexPath.row]
        cell.delegate = self
        cell.configCell(item)
        
        cell.vehicleCommentLabel.text = item.vehicleComment
        cell.trailerCommentLabel.text = item.trailerComment
        
        let sortedTagNames = item.vehicleTags.keys.sorted(by: {$0 < $1}).compactMap({ item.vehicleTags[$0]})
        
        print("Sorted tag names: \(sortedTagNames.map {$0.name})")
        
        let joinedTagNames = sortedTagNames.map { $0.name}.joined(separator: ", ")
        
        cell.tagNameLabel.text = joinedTagNames

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goChecklistAddComment" {
            let addCommentVC = segue.destination as! ChecklistAddCommentVC
            addCommentVC.delegate = self
        }
        
        if segue.identifier == "goChecklistAddTag" {
            let addTagVC = segue.destination as! ChecklistAddTagVC
            addTagVC.delegate = self
            addTagVC.addedTags = itemSections[lastIndexPath.section].checklistItems[lastIndexPath.row].vehicleTags
        }
    }
}

extension ChecklistVC: ChecklistCellDelegate {
    func tapGestureOnCell(_ cell: ChecklistCell) {
        
        showOptionsOnCellTapped(questionsTableView.indexPath(for: cell)!)
    }
    
    func showOptionsOnCellTapped(_ indexPath: IndexPath){
        
        let addComment = UIAlertAction(title: "📝 Add Comment", style: .default) { action in
            self.lastIndexPath = indexPath
            self.performSegue(withIdentifier: "goChecklistAddComment", sender: nil)
        }
        
        let addTag = UIAlertAction(title: "🏷 Add Tag ⤵", style: .default) { action in
            self.showOptionsForAddTag(indexPath)
        }

        let actionSheet = configureActionSheet()
        actionSheet.addAction(addComment)
        actionSheet.addAction(addTag)

        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // A menu from where the user can choose to add tags for Vehicle or Trailer
    func showOptionsForAddTag(_ indexPath: IndexPath){
        
        self.lastIndexPath = indexPath
        let addVehicleTag = UIAlertAction(title: "Add Vehicle tag", style: .default) { action in
            self.performSegue(withIdentifier: "goChecklistAddTag", sender: nil)
        }
        let addTrailerTag = UIAlertAction(title: "Add Trailer tag", style: .default) { action in
            self.performSegue(withIdentifier: "goChecklistAddTag", sender: nil)
        }
        let actionSheet = configureActionSheet()
        actionSheet.addAction(addVehicleTag)
        actionSheet.addAction(addTrailerTag)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func configureActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancel)
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            actionSheet.popoverPresentationController?.sourceView = self.view
            actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            actionSheet.popoverPresentationController?.permittedArrowDirections = []
        }
        
        return actionSheet
    }
}

// Receive Comments from ChecklistAddCommentVC using the Delegate Pattern
extension ChecklistVC: ChecklistAddCommentDelegate {
    
    func receiveVehicleComment(vehicleComment: String?, trailerComment: String?) {
        
        let item = itemSections[lastIndexPath.section].checklistItems[lastIndexPath.row]
        item.vehicleComment = vehicleComment ?? String()
        item.trailerComment = trailerComment ?? String()

        questionsTableView.reloadData()
    }
}

// Receive Tags from ChecklistAddTagVC using the Delegate Pattern
extension ChecklistVC: ChecklistAddTagVCDelegate{
    
    func receiveAddedTags(tags: [Int : Tag]) {
        
        let item = self.itemSections[self.lastIndexPath.section].checklistItems[self.lastIndexPath.row]
        item.vehicleTags = tags
    }
}
