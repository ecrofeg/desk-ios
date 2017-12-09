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
                var tasksArray = [Task]()
                
                for (key, value) in tasks {
                    let task = Task(
                        id: Int(key)!,
                        title: value["name"].string!,
                        description: value["description"].string!,
                        priority: value["priority"].int!,
                        createdAt: value["created_at"].string!,
                        updatedAt: value["updated_at"].string!
                    )
                    
                    tasksArray.append(task)
                }
                
                tasksArray.sort { return $0.priority > $1.priority }
                
                self.tasks = tasksArray
            
                // Re-render table's content
                self.tableView.reloadData()
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
        
        // Show large iOS 11 like titles
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Append Search Bar and preserve it visible
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Load tasks for current user and reload the table view
        loadTasks()
    }

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
        
        // Fill the cell with task data
        cell.title.text = "\(task.id): \(task.title)"
        cell.shortDescription.text = task.description

        return cell
    }
}
