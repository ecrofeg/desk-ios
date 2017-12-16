import UIKit
import Alamofire
import SwiftyJSON

@IBDesignable
class TasksTableViewController: UITableViewController {
    private var tasks = [Task]()
    
    @IBAction func showActionSheet(_ sender: UIBarButtonItem) {
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "New Task", style: .default, handler: { _ in
            if let storyboard = self.storyboard {
                let viewController = storyboard.instantiateViewController(withIdentifier: "NewTaskPopoverViewControllerID")
                self.present(viewController, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "New Project", style: .default, handler: { _ in
            if let storyboard = self.storyboard {
                let viewController = storyboard.instantiateViewController(withIdentifier: "NewProjectPopover")
                self.present(viewController, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loadTasks() {
        Alamofire.request("http://localhost:5555/api/task?assignee_id=1").responseJSON { response in
            switch response.result {
                case .success(let value):
                    guard let tasks = JSON(value)["tasks"].dictionary else {
                        return
                    }

                    var tasksArray = [Task]()
                    
                    for (_, taskJSON) in tasks {
                        let task = Task(
                            id: taskJSON["id"].int!,
                            title: taskJSON["name"].string!,
                            description: taskJSON["description"].string!,
                            priority: taskJSON["priority"].int!,
                            createdAt: taskJSON["created_at"].string!,
                            updatedAt: taskJSON["updated_at"].string!
                        )
                        
                        tasksArray.append(task)
                    }
                    
                    // Sort tasks by priority
                    tasksArray.sort { return $0.priority > $1.priority }
                    
                    // Store sorted tasks
                    self.tasks = tasksArray
                    
                    // Draw tab bar item badge with number of tasks assigned to the current user
                    if (tasksArray.count > 0) {
                        if let barItems = self.tabBarController?.tabBar.items {
                            for item in barItems {
                                if item.title == "Tasks" {
                                    item.badgeValue = String(tasksArray.count)
                                    break
                                }
                            }
                        }
                    }
                
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
                controller.taskId = tasks[indexPath.row].id
                controller.title = tasks[indexPath.row].title
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
