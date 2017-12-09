//
//  TasksTableViewController.swift
//  desk
//
//  Created by Павел Наумов on 09/12/2017.
//  Copyright © 2017 pnaumov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TasksTableViewController: UITableViewController {
    
    private var tasks = [Task]()
    
    private func loadTasks() {
        Alamofire.request("http://localhost:5555/api/task?assignee_id=1").responseJSON { response in
            switch response.result {
                case .success(let value):
                    let tasks = JSON(value)["tasks"].dictionary!
                    
                    for (key, value) in tasks {
                        let id = Int(key)!
                        let title = value["name"].string!
                        let description = value["description"].string!
                        
                        self.tasks.append(Task(id: id, title: title, description: description))
                    }
                
                    self.tableView.reloadData()
                
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewTask" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! TaskViewController
                let task = tasks[indexPath.row]
                
                controller.task = task
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTasks()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TasksTableViewCell else {
            fatalError()
        }
        
        let task = tasks[indexPath.row]

        cell.title.text = "\(task.id): \(task.title)"
        cell.shortDescription.text = task.description

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
