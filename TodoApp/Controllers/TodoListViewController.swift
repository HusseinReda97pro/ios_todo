//
//  ViewController.swift
//  TodoApp
//
//  Created by Hussein Reda on 27/09/2024.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Todo 1","Todo 2","Todo 3","Todo 4","Todo 5",]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoList") as? [String] {
            itemArray =  items
        }

    }
    
    //MARK:-  TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:- TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        if(cell.accessoryType  == .none){
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK:- Add new item
    @IBAction func addNewTodoButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            if textFiled.text != nil && !textFiled.text!.isEmpty {
                self.itemArray.append(textFiled.text!)
                self.defaults.set(self.itemArray, forKey: "TodoList")
                self.tableView.reloadData()
            }
        }
        
        
        alert.addTextField{ alertTextFiled in
            alertTextFiled.placeholder = "Create new item"
            textFiled = alertTextFiled
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
}

