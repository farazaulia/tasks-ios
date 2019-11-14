//
//  ViewController.swift
//  Tasks
//
//  Created by Faraz Muhammad Aulia on 14/11/19.
//  Copyright © 2019 Faraz Muhammad Aulia. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    var itemArray = [TaskItem]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Tasks.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(self.dataFilePath!)
        
        loadItems()
        
    }

    // MARKS - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    // MARK - Add New Item
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add I tem", style: .default) { (action) in
            // what will happen once the user clicks the add item button on our UIAlert
            
            let newItem = TaskItem()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "What do you want to do?"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() -> Void {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
    }
    
    func loadItems() -> Void {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([TaskItem].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}

