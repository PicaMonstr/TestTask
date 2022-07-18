import Foundation

protocol ViewControllerModelDelegate: AnyObject {
    
    func reloadData()
}

enum sortType {
    
    case time
    case likes
}

class ViewControllerModel {
    
    weak var delegatePost: ViewControllerModelDelegate?

    private lazy var request: Request = Request()
    
    private lazy var sortBy: sortType = .likes

    private(set) var posts: [Post]? {
        didSet {
            delegatePost?.reloadData()
        }
    }
    
    func sortPosts() {
        if let posts = posts {
            switch sortBy {
            case .time:
                self.posts = posts.sorted(by: { $0.likes > $1.likes })
                sortBy = .likes
            case .likes:
                self.posts = posts.sorted(by: { $0.time > $1.time })
                sortBy = .time
                
            }
        }
    }
    
    func getPosts() {
        request.request { [weak self] posts in
            self?.posts = posts.posts
        }
    }
}
