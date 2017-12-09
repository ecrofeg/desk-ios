import UIKit
import Alamofire
import SwiftyJSON

class TaskViewController: UIViewController {
    
    public var taskId: Int!
    private var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        Alamofire.request("http://localhost:5555/api/task/\(self.taskId!)").responseJSON { response in
            switch response.result {
            case .success(let value):
                let tasks = JSON(value)["tasks"].dictionary!
                
                if let task = tasks[String(self.taskId)] {
                    self.task = Task(
                        id: task["id"].int!,
                        title: task["name"].string!,
                        description: task["description"].string!,
                        priority: task["priority"].int!,
                        createdAt: task["created_at"].string!,
                        updatedAt: task["updated_at"].string!
                    )
                    
                    self.navigationItem.title = task["name"].string!
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
