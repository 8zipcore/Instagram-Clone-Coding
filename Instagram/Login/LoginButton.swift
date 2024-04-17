//
//  LoginButton.swift
//  Instagram
//
//  Created by 홍승아 on 4/11/24.
//

import UIKit

class LoginButton: UIButton {
    
    enum Style{
        case blue
        case lightblue
        case lightgray
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView(){
        self.layer.cornerRadius = 20
        self.titleLabel?.font = SDGothic(size: 16)
    }
    
    func setButton(_ style: Style){
        switch style {
        case .blue:
            self.backgroundColor = RGB(red: 0, green: 100, blue: 224)
            self.tintColor = .white
        case .lightblue:
            let lightBlue = RGB(red: 69, green: 153, blue: 254)
            self.layer.borderWidth = 1
            self.layer.borderColor = lightBlue.cgColor
            self.tintColor = lightBlue
        case .lightgray:
            let lightGray = RGB(red: 70, green: 90, blue: 105)
            self.layer.borderWidth = 1
            self.layer.borderColor = lightGray.cgColor
            self.tintColor = .white
        }
    }

}
