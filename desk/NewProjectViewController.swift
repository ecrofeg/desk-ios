import UIKit
import Alamofire

class NewProjectViewController: UIViewController {
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var shortcutInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let parameters: Parameters = [
            "name": titleInput.text!,
            "description": descriptionInput.text!,
            "shortcut": shortcutInput.text!, // Some simple abbrv `DESK` or something
            "author_id": 1 // Hardcoded for now
        ];
        
        Alamofire.request("http://localhost:5555/api/project", method: .put, parameters: parameters).responseJSON { response in
            switch response.result {
                case .success(_):
                    self.dismiss(animated: true)
                
                case .failure(_):
                    let alert = UIAlertController(title: "An error occured", message: "Something went wrong! Please, try again.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
