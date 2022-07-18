import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var model = ViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getPosts()
        model.delegatePost = self
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "post",
           let vc = segue.destination as? DetailViewController, let index = sender as? IndexPath {
//            let vc = segue.destination as! DeteilViewController
//            let index = sender as! IndexPath
            let id = model.posts![index.row].id
            vc.id = id
        }
    }
    
    @IBAction func sortPost() {
        model.sortPosts()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { return UITableViewCell() }
        cell.config(item: model.posts![indexPath.row])
        
        cell.willChangeHeight = {
            tableView.beginUpdates()
        }
        
        cell.didChangeHeight = {
            tableView.endUpdates()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "post", sender: indexPath)
    }
}

extension ViewController: ViewControllerModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
