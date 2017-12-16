import UIKit

class NewTaskPopoverViewController: UIViewController, DelegateProject {
    private var selectedProject: Project?
    @IBOutlet weak var projectToggler: UIView!
    @IBOutlet weak var selectedProjectLabel: UILabel!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

    func selectProject() {
        selectedProject = nil
        selectedProjectLabel.text = "None"
        selectedProjectLabel.textColor = UIColor.lightGray
    }
    
    func selectProject(project: Project) {
        selectedProject = project
        selectedProjectLabel.text = project.title
        selectedProjectLabel.textColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SelectProjectTableViewController {
            destinationViewController.delegate = self
        }
    }
}
