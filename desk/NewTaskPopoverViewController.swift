import UIKit

class NewTaskPopoverViewController: UIViewController, DelegateProject {
    @IBOutlet weak var projectToggler: UIView!
    @IBOutlet weak var selectedProjectLabel: UILabel!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    private var selectedProject: Project?
    
    func selectProject(project: Project) {
        selectedProject = project
        selectedProjectLabel.text = project.title
        selectedProjectLabel.textColor = UIColor.black
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? SelectProjectTableViewController {
            destinationViewController.delegate = self
        }
    }
}
