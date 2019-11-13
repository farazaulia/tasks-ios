//
//  ViewController.swift
//  Tasks
//
//  Created by Faraz Muhammad Aulia on 14/11/19.
//  Copyright © 2019 Faraz Muhammad Aulia. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "Buy Eggs", "Buy Foods"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    

}

