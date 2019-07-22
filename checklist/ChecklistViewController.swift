//
//  ViewController.swift
//  checklist
//
//  Created by Leah Yassky on 7/11/19.
//  Copyright © 2019 Leah Yassky. All rights reserved.
//

import UIKit

// CORRECT i think that this is commented .. 
//protocol AddItemViewControllerDelegate: class { //it can only work with classes
//    func addItemViewControllerDidCancel (_ controller: AddItemTableViewController)
//    func addItemViewController (_ controller:AddItemTableViewController, didFinishAdding item: ChecklistItem)
//}



class ChecklistViewController: UITableViewController {
    
    
    var todoList: TodoList
    
    //have to add a function/specification here for the date/time and the status FIRST before CTRL+drag buttons over to the ChecklistViewController interface from the Main.storyboard.

    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = todoList.todos.count
        _ = todoList.newTodo() // using _ lets xcode know we are not interested in working with object created by this
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        todoList = TodoList()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todos.count //this creates however many rows (dynamic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = todoList.todos[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //action for when a row is selected. this is the DELEGATE, aka, when a row is selected, we delegate action accordingly here. this could be where you set a checkmark, edit an item, play music, turn screen different color, animate tapping of row, etc. 
        if let cell = tableView.cellForRow(at: indexPath){
            let item = todoList.todos[indexPath.row]
            configureCheckmark(for: cell, with: item)
            tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        todoList.todos.remove(at: indexPath.row)
        //let indexPaths = [indexPath]
        //tableView.deleteRows(at: indexPaths, with: .automatic)
        tableView.reloadData() //this is equivalent to the previous two lines
    }
        
    func configureText(for cell: UITableViewCell, with item: ChecklistItem){
        if let label = cell.viewWithTag(1000) as? UILabel{
            label.text = item.text
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem){
        guard let checkmark = cell.viewWithTag(1001) as? UILabel else {
            return
        }
        if item.checked {
            checkmark.text = "√"
            //cell.accessoryType = .checkmark } // switch if want to add without checkmark
        } else {
            checkmark.text = ""
            //cell.accessoryType = .none
        }
        item.toggleChecked()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemViewController = segue.destination as? AddItemTableViewController {
                addItemViewController.delegate = self
                addItemViewController.todoList = todoList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let addItemViewController = segue.destination as? AddItemTableViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell){
                    let item = todoList.todos[indexPath.row]
                    addItemViewController.itemToEdit = item
                    addItemViewController.delegate = self
                    
                }
            }
        }
    }
    
    
    
}



extension ChecklistViewController: AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count - 1
        //todoList.todos.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func addItemViewController(_ controller: AddItemTableViewController, didFinishEditing item: ChecklistItem) {
        if let index = todoList.todos.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
}
