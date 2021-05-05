import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet var lapLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lapLabel.text = nil
        timeLabel.text = nil
    }
    
    func setUpCell(with cell:stopWatch){
        lapLabel.text = cell.label
        timeLabel.text = cell.time
    }

}
