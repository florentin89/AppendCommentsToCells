//
//  ChecklistAddCommentVC.swift
//  AppendCommentsToCells
//
//  Created by Florentin Lupascu on 07/05/2019.
//  Copyright © 2019 Florentin Lupascu. All rights reserved.
//

import UIKit

protocol ChecklistAddCommentDelegate {
    func receiveVehicleComment(vehicleComment: String?, trailerComment: String?)
}

class ChecklistAddCommentVC: UIViewController {
    
    // Interface Links
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cancelBtnOutlet: UIButton!
    @IBOutlet weak var saveBtnOutlet: UIButton!
    @IBOutlet weak var vehicleCommentTextField: UITextField!
    @IBOutlet weak var trailerCommentTextField: UITextField!
    @IBOutlet weak var popUpView: UIView!
    
    // Properties
    var delegate: ChecklistAddCommentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // Setup the design for outlets
    func setupViews(){
        
        popUpView.layer.cornerRadius = 20
        popUpView.layer.masksToBounds = true
        
        cancelBtnOutlet.layer.cornerRadius = 5
        saveBtnOutlet.layer.cornerRadius = 5
        
        self.hideKeyboard()
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
        checkCommentsTextFields()
        dismiss(animated: true, completion: nil)
    }
    
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func checkCommentsTextFields(){
        
        if isEmpty(vehicleCommentTextField){
            clearTextFields()
        }
        else if notEmpty(vehicleCommentTextField) || notEmpty(trailerCommentTextField){
            sendDataBack()
        }
    }
    
    // Check if the textfield is not empty
    fileprivate func notEmpty(_ field: UITextField) -> Bool {
        return !(field.text?.isEmpty)!
    }
    
    // Check if the textfield is empty
    fileprivate func isEmpty(_ field: UITextField) -> Bool {
        return (field.text?.isEmpty)!
    }
    
    // Clear textfields
    func clearTextFields(){
        vehicleCommentTextField.text = String()
        trailerCommentTextField.text = String()
    }
    
    // Function used to send data back from the AddComment PopUp to ChecklistVC
    func sendDataBack(){
        
        if delegate != nil{
            if notEmpty(vehicleCommentTextField) || notEmpty(trailerCommentTextField){
                delegate?.receiveVehicleComment(vehicleComment: vehicleCommentTextField.text, trailerComment: trailerCommentTextField.text)
            }
        }
    }
    
    // Function to hide the Popup when the user click anywhere on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            dismiss(animated: true, completion: nil)
        }
    }
}
