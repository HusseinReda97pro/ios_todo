//
//  ViewController.swift
//  TodoApp
//
//  Created by Hussein Reda on 27/09/2024.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK:-  TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:- TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)!
        //
        //        if(cell.accessoryType  == .none){
        //            cell.accessoryType = .checkmark
        //        }else {
        //            cell.accessoryType = .none
        //        }
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    //MARK:- Add new item
    @IBAction func addNewTodoButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            if textFiled.text != nil && !textFiled.text!.isEmpty {
                
                let newItme = Item(context: self.context)
                newItme.title = textFiled.text!
                newItme.done  =  false
                self.itemArray.append(newItme)
                self.saveData()
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
    
    
    func saveData(){
        do {
            try  self.context.save()
        }catch{
            print("error saving context \(error)")
        }
        
    }
    
    func loadData(){
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try  context.fetch(request)
        }catch{
            print("error load data \(error)")
            
        }
    }


}

