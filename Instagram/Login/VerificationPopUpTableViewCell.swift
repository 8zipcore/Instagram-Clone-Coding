//
//  VerificationPopUpTableViewCell.swift
//  Instagram
//
//  Created by 홍승아 on 4/26/24.
//

import UIKit
import SnapKit

class VerificationPopUpTableViewCell: UITableViewCell {
    
    static let identifier = "VerificationPopUpTableViewCell"
    
    var label = UILabel()
    var lineView = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(){
        self.contentView.clipsToBounds = true
        self.selectionStyle = .none
        self.backgroundColor = RGB(red: 30, green: 43, blue: 52)
        
        label.font = SDGothicSemiBold(size: 16)
        label.textColor = .white
        lineView.backgroundColor = RGB(red: 255, green: 255, blue: 255, alpha: 0.2)
        
        self.addSubview(label)
        self.addSubview(lineView)
        
        label.snp.makeConstraints{ make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
            make.width.equalTo(self.contentView.bounds.width * 0.95)
        }
        
        lineView.snp.makeConstraints{ make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.height.equalTo(0.3)
        }
    }
    
    func updateUI(_ text: String, _ isFirst: Bool){
        label.text = text
        lineView.isHidden = isFirst
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted{
            UIView.animate(withDuration: 0.2, animations: {
                self.label.transform = CGAffineTransform(scaleX: 0.99, y: 1)
                self.label.textColor = UIColor(white: 1, alpha: 0.8)
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.label.transform = .identity
                self.label.textColor = .white
            })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
