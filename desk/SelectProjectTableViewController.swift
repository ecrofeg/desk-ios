import UIKit
import Alamofire
import SwiftyJSON

protocol DelegateProject {
    func selectProject(project: Project)
}

class SelectProjectTableViewController: UITableViewController {
    var delegate: DelegateProject?
    private var projects = [Project]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://localhost:5555/api/project").responseJSON { response in
            switch response.result {
                case .success(let value):
                    guard let tasks = JSON(value)["projects"].dictionary else {
                        return
                    }
                    
                    var projectsArray = [Project]()
                    
                    for (_, projectJSON) in tasks {
                        let project = Project(
                            id: projectJSON["id"].int!,
                            title: projectJSON["name"].string!,
                            description: projectJSON["description"].string!,
                            createdAt: projectJSON["created_at"].string!,
                            updatedAt: projectJSON["updated_at"].string!
                        )
                        
                        projectsArray.append(project)
                    }
                    
                    // Store sorted projects
                    self.projects = projectsArray
                    
                    // Re-render table's content
                    self.tableView.reloadData()
                
                case .failure(let error):
                    print(error)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectProjectCell", for: indexPath)
        let project = projects[indexPath.row]
        
        cell.textLabel?.text = project.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let project = projects[indexPath.row]
        
        // Pass selected project back to form
        delegate?.selectProject(project: project)
        
        // Go backwards
        navigationController?.popViewController(animated: true)
    }
}
