import UIKit
import Alamofire
import SwiftyJSON

class TaskViewController: UIViewController {
    
    public var taskId: Int!
    private var task: Task?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "..."
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let task = self.task {
            loadPage(task: task)
        }
        else {
            Alamofire.request("http://localhost:5555/api/task/\(self.taskId!)").responseJSON { response in
                switch response.result {
                case .success(let value):
                    let tasks = JSON(value)["tasks"].dictionary!
                    
                    if let taskJSON = tasks[String(self.taskId)] {
                        let task = Task(
                            id: taskJSON["id"].int!,
                            title: taskJSON["name"].string!,
                            description: taskJSON["description"].string!,
                            priority: taskJSON["priority"].int!,
                            createdAt: taskJSON["created_at"].string!,
                            updatedAt: taskJSON["updated_at"].string!
                        )
                        
                        self.task = task
                        self.loadPage(task: task)
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func loadPage(task: Task) {
        navigationItem.title = task.title
    }
}
