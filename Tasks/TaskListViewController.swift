//
//  ViewController.swift
//  Tasks
//
//  Created by Faraz Muhammad Aulia on 14/11/19.
//  Copyright © 2019 Faraz Muhammad Aulia. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    var itemArray = [ "Find Mike", "Buy Eggs", "Buy Foods"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "TaskList") as? [String] {
            itemArray = items
        }
    }

    // MARKS - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    // MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    // MARK - Add New Item
    @IBAction func addItemButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add I tem", style: .default) { (action) in
            // what will happen once the user clicks the add item button on our UIAlert
            self.itemArray.append(textField.text!)
            
            // store array item
            self.defaults.set(self.itemArray, forKey: "TaskList")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "What do you want to do?"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

