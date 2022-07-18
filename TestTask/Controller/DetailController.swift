import Foundation
import UIKit

class DetailViewController: UIViewController {
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private let model = DetailControllerModel()

    var id: Int? {
        didSet {
            model.getPost(id: id!)
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
    
    func reloadView() {
        if let postId = model.postId {
        tableView.reloadData()
        imageView.sd_setImage(with: postId.post.url)
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? DeteilPostCell else { return UITableViewCell() }
        if let postId = model.postId {
            cell.config(post: postId.post)
        }
        return cell
    }
}

extension DetailViewController: DetailViewControllerDelegate {
    
    func reloadData() {
        reloadView()
    }
}
