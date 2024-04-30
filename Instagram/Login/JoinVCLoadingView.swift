//
//  JoinVCLoadingView.swift
//  Instagram
//
//  Created by 홍승아 on 4/29/24.
//

import UIKit
import SnapKit

class JoinVCLoadingView: UIView {
    
    private let color = UIColor(white: 0.6, alpha: 0.2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(){
        self.backgroundColor = .clear
        
        var viewArray: [UIView] = []
        let cornerRadiusArray:[CGFloat] = [15, 10, 10, 10, 13, 13]
        
        for index in 0..<6{
            viewArray.append(UIView())
            viewArray[index].backgroundColor = color
            viewArray[index].layer.cornerRadius = cornerRadiusArray[index]
            self.addSubview(viewArray[index])
        }
        
        let horizontalMargin = 10
        
        viewArray[0].snp.makeConstraints{ make in
            make.top.equalTo(self)
            make.leading.equalTo(self).inset(horizontalMargin)
            make.width.equalTo(self.bounds.width * 0.6)
            make.height.equalTo(30)
        }
        
        let contentHeight = 16
        
        viewArray[1].snp.makeConstraints{ make in
            make.top.equalTo(viewArray[0].snp.bottom).offset(20)
            make.leading.equalTo(self).inset(horizontalMargin)
            make.width.equalTo(self.bounds.width * 0.7)
            make.height.equalTo(contentHeight)
        }
        
        let contentTopPadding = 6
        
        viewArray[2].snp.makeConstraints{ make in
            make.top.equalTo(viewArray[1].snp.bottom).offset(contentTopPadding)
            make.leading.equalTo(self).inset(horizontalMargin)
            make.width.equalTo(self.bounds.width * 0.7)
            make.height.equalTo(contentHeight)
        }
        
        viewArray[3].snp.makeConstraints{ make in
            make.top.equalTo(viewArray[2].snp.bottom).offset(contentTopPadding)
            make.leading.equalTo(self).inset(horizontalMargin)
            make.width.equalTo(self.bounds.width * 0.4)
            make.height.equalTo(contentHeight)
        }
        
        viewArray[4].snp.makeConstraints{ make in
            make.top.equalTo(viewArray[3].snp.bottom).offset(30)
            make.leading.equalTo(self).inset(horizontalMargin)
            make.trailing.equalTo(self).inset(horizontalMargin)
            make.height.equalTo(50)
        }
        
        viewArray[5].snp.makeConstraints{ make in
            make.bottom.equalTo(self)
            make.leading.equalTo(self).inset(horizontalMargin)
            make.trailing.equalTo(self).inset(horizontalMargin)
            make.height.equalTo(50)
        }
    }

}
