import Foundation

protocol RequestProtocol {
    func request(complition: @escaping (Posts) -> Void)
    func requestPost(id: Int, complition: @escaping (Id) -> Void)
}
