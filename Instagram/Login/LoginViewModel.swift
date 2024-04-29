//
//  LoginViewModel.swift
//  Instagram
//
//  Created by 홍승아 on 4/24/24.
//

import Foundation

class LoginViewModel{
    
    enum PopUpAction{
        case confirm
    }
    
    func popupText(_ style: LoginViewController.PopUpStyle)-> PopUpText{
        switch style{
        case .invalidPassword:
            return PopUpText(title: "잘못된 비밀번호", message: "입력된 비밀번호가 올바르지 않습니다. 다시 시도하세요.")
        }
    }
    
    func actionText(_ style: PopUpAction)-> String{
        switch style{
        case .confirm:
            return "확인"
        }
    }
}
