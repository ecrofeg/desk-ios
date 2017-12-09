import UIKit

class TaskViewController: UIViewController {
    
    public var task: Task!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = task.title
        navigationItem.largeTitleDisplayMode = .never
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
