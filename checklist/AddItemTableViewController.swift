//
//  AddItemTableViewController.swift
//  checklist
//
//  Created by Leah Yassky on 7/12/19.
//  Copyright © 2019 Leah Yassky. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class { //it can only work with classes
    func addItemViewControllerDidCancel (_ controller: AddItemTableViewController)
    func addItemViewController (_ controller:AddItemTableViewController, didFinishAdding item: ChecklistItem)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController {

    weak var delegate: AddItemViewControllerDelegate?
    weak var todoList: TodoList?
    weak var itemToEdit: ChecklistItem?
    
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var textfield: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        //navigationController?.popViewController(animated: true)
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) { //what to do when the done button is pressed
        
        // NSDate formatter (idk wording)
        
        //navigationController?.popViewController(animated: true)
        //print("contents of the textfield \(textfield.text)")
        //pass data
        if let item = itemToEdit, let text = textfield.text{
            item.text = text
            delegate?.addItemViewController(self, didFinishEditing: item)
            
        } else {
            if let item = todoList?.newTodo() {
                if let textFieldText = textfield.text { //send a new item back
                    item.text = textFieldText
                }
                item.checked = false
                delegate?.addItemViewController(self, didFinishAdding: item)
            }
        }
    }
    
    
    
    override func viewDidLoad() { //configure the cell, do any additional setup
        super.viewDidLoad()
        if let item = itemToEdit{
            title = "Edit Item"
            textfield.text = item.text
            addBarButton.isEnabled = true
        }
        navigationItem.largeTitleDisplayMode = .never
        textfield.delegate = self
        //TODO: dateTimePicker.date = NSDate.date?

    }

    
    override func viewWillAppear(_ animated: Bool) {
        //this is where you make it so the keyboard comes up on its own w/o having to
        textfield.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
   
    
    
    }

extension AddItemTableViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder() // sends keyboard down when hit done after typing in input to item
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {  //when a user taps, this is called to manipulate what user is typing before it is shown in the text field
       
        guard let oldText = textfield.text,
            let stringRange = Range(range, in: oldText) else{
            return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty{
            addBarButton.isEnabled = false
        } else {
            addBarButton.isEnabled = true
        }
        return true
    }
}





