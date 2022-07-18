import Foundation

protocol DeteilViewControllerDelegate: AnyObject {
    
    func reloadData()
    
}

class DeteilControllerModel {
    
    weak var delegatePostId: DeteilViewControllerDelegate?
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
