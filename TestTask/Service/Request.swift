import Alamofire
import Foundation
struct Request: RequestProtocol {
    
    func requestPost(id: Int, complition: @escaping (Id) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(String(id)).json?") else { return }
        AF.request(url)
            .responseDecodable(of: Id.self) { response in
                if let error = response.error {
                    print(error)
                    return
                }
                if let post = response.value {
                    complition(post)
                }
            }

    }
    
    func request(complition: @escaping (Posts) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json") else { return }
        AF.request(url)
            .responseDecodable(of: Posts.self) { response in
                if let error = response.error {
                    print(error)
                    return
                }
                if let posts = response.value {
                    complition(posts)
                }
            }
    }
}
