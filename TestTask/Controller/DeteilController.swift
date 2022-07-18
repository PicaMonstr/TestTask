import Foundation
import UIKit

class DeteilViewController: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private let model = DeteilControllerModel()

    var id: Int? {
        didSet {
            model.getPost(id: id!)
        }
    }
    
    func reloadView() {
        if let postId = model.postId {
        tableView.reloadData()
        imageView.sd_setImage(with: postId.post.url)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegatePostId = self
    }
}

extension DeteilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? DeteilPostCell else { return UITableViewCell() }
        if let postId = model.postId {
        cell.config(post: postId.post)
        }
        return cell
    }
    
    
}

extension DeteilViewController: DeteilViewControllerDelegate {
    
    func reloadData() {
        reloadView()
    }
}
