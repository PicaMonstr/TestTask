import Foundation

struct Post: Codable {
    
    var id: Int
    var time: Int
    var title: String
    var text: String
    var likes: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "postId"
        case time = "timeshamp"
        case title
        case text = "preview_text"
        case likes = "likes_count"
    }
}

struct Posts: Codable {
    var posts: [Post]
}

struct PostId: Codable {
    var url: URL
    var time: Int
    var title: String
    var text: String
    var likes: Int

    enum CodingKeys: String, CodingKey {
        case url = "postImage"
        case time = "timeshamp"
        case title
        case text = "text"
        case likes = "likes_count"
    }
}

struct Id: Codable {
    var post: PostId
}
