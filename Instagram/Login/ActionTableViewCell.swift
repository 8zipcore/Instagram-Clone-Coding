//
//  ActionTableViewCell.swift
//  Instagram
//
//  Created by 홍승아 on 4/22/24.
//

import UIKit
import SnapKit

class ActionTableViewCell: UITableViewCell {
    
    static let identifier = "ActionTableViewCell"
    
    var lineView = UIView()
    var actionLabel: UILabel = UILabel()
    
    private let selectedBackgroundColor = UIColor(white: 0.5, alpha: 0.4)
    private let fontSize = 18
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(){
        self.backgroundColor = .clear
        
        self.contentView.clipsToBounds = true
        self.selectionStyle = .none
        
        self.lineView.backgroundColor = RGB(red: 255, green: 255, blue: 255, alpha: 0.2)
        
        actionLabel.textColor = RGB(red: 70, green: 147, blue: 255)
        actionLabel.font = SDGothic(size: fontSize)
        actionLabel.textAlignment = .center
        
        self.addSubview(lineView)
        self.addSubview(actionLabel)
        
        lineView.snp.makeConstraints{ make in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(0.3)
        }
        
        actionLabel.snp.makeConstraints{ make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.bottom.equalTo(self).inset(10)
            make.leading.equalTo(self).inset(10)
            make.trailing.equalTo(self).inset(10)
        }
    }
    
    func updateUI(_ text: String, _ isFirst: Bool){
        actionLabel.font = isFirst ? SDGothicBold(size: fontSize) : SDGothic(size: fontSize)
        actionLabel.text = text
        self.isSelected = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.backgroundColor = selected ? selectedBackgroundColor : .clear
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        self.backgroundColor = highlighted ? selectedBackgroundColor : .clear
    }

}
