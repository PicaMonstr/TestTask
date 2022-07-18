import Foundation

protocol DetailViewControllerDelegate: AnyObject {
    
    func reloadData()
    
}

class DetailControllerModel {
    
    weak var delegatePostId: DetailViewControllerDelegate?
    private lazy var request: Request = Request()
    
    private(set) var postId: Id? {
        didSet {
            delegatePostId?.reloadData()
        }
    }
    
    func getPost(id: Int) {
        request.requestPost(id: id) { [weak self] postId in
            self?.postId = postId
        }
    }
}
