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
    @IBOutlet weak var heightConstriant: NSLayoutConstraint!
    
    var isExpand: Bool = true
    var onArrowClick: ((UIButton)->())!
    
    var willChangeHeight: (() -> Void)!
    var didChangeHeight: (() -> Void)!
    
    @IBAction func handleArrowButton(sender: UIButton) {
        willChangeHeight()
        isExpand.toggle()
        if isExpand {
            heightConstriant.constant = 41
        } else {
            heightConstriant.constant = textsLabel.text?.height(withConstrainedWidth: textsLabel.frame.size.width, font: textsLabel.font) ?? 120
        }
        updateArrowImage(expandStatus: isExpand)
        didChangeHeight()
        layoutIfNeeded()
    }
    
    func updateArrowImage(expandStatus: Bool) {
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
        button.isHidden = !canExpand(with: textsLabel.text ?? "")
    }
    
    func canExpand(with text: String) -> Bool {
        text.height(
            withConstrainedWidth: textsLabel.frame.size.width,
            font: textsLabel.font
        ) > textsLabel.font.lineHeight * 2 + 2
    }
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
