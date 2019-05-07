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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
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

        let actionSheet = configureActionSheet()
        actionSheet.addAction(addComment)

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

// Receive Comments using the Delegate
extension ChecklistVC: ChecklistAddCommentDelegate {
    
    func receiveVehicleComment(vehicleComment: String?, trailerComment: String?) {
        
        let item = itemSections[lastIndexPath.section].checklistItems[lastIndexPath.row]
        item.vehicleComment = vehicleComment ?? ""
        item.trailerComment = trailerComment ?? ""

        questionsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goChecklistAddComment" {
            let addCommentVC = segue.destination as! ChecklistAddCommentVC
            addCommentVC.delegate = self
        }
    }
}
