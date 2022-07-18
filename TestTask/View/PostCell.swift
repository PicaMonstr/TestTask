import UIKit

protocol PostCellDelegate: AnyObject {
    func reloadCellData()
}

class PostCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var isExpand: Bool = false
    var onArrowClick: ((UIButton)->())!
       
       @IBAction func handleArrowButton(sender: UIButton){
           onArrowClick(sender)
           if isExpand == true {
               textsLabel.numberOfLines = 2
           } else {
               textsLabel.numberOfLines = 0
           }
       }

       func updateArrowImage(expandStatus: Bool){
           button.setTitle(expandStatus ? "expand" : "collapse", for: .normal)
       }
    func config(item: Post) {
        nameLabel.text = item.title
        textsLabel.text = item.text
        likesLabel.text = String(item.likes) + "\u{2665}"
        let date = Date(timeIntervalSince1970: Double(item.time))
        let time = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
        timeLabel.text = time
        button.setTitle("expand", for: .normal)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
