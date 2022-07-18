import Foundation
import UIKit

class DeteilPostCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func config(post: PostId) {
        nameLabel.text = post.title
        textsLabel.text = post.text
        likesLabel.text = String(post.likes) + "❤️"
        let date = Date(timeIntervalSince1970: Double(post.time))
        let time = DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none)
        timeLabel.text = time
    }
}
