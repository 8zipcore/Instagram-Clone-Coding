//
//  JoinViewModel.swift
//  Instagram
//
//  Created by 홍승아 on 4/19/24.
//

import Foundation

class JoinViewModel{
    
    struct JoinViewText{
        var title: String
        var content: String
        var placeHolder: String
        var notificationText: String
        var changeText: String
        var exitText: String
    }
    
    enum PopUpAction{
        case login
        case stop
        case cancel
        case resendVerficationCode
        case changeEmailAddress
        case phoneNumberVerfication
    }
    
    func text(_ viewType: JoinViewController.ViewType)-> JoinViewText{
  
        switch viewType{
        case .emailJoin:
            return JoinViewText(title: "이메일 주소 입력",
                                content: "회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다.",
                                placeHolder: "이메일",
                                notificationText: "",
                                changeText: "휴대폰 번호로 가입하기",
                                exitText: "이미 계정이 있으신가요?")
        case .phoneNumberJoin:
            return JoinViewText(title: "휴대폰 번호 입력",
                                content: "회원님에게 연락할 수 있는 휴대폰 번호를 입력하세요. 이 휴대폰 번호는 프로필에서 다른 사람에게 공개되지 않습니다.",
                                placeHolder: "휴대폰 번호",
                                notificationText: "보안 및 로그인 목적으로 Instagram에서 보내는 SMS 알림을 수신할 수 있습니다.",
                                changeText: "이메일 주소로 가입하기",
                                exitText: "이미 계정이 있으신가요?")
        case .emailVerification:
            return JoinViewText(title: "인증 코드 입력",
                                content: "계정을 확인하려면 %s 주소로 전송된 6자리 코드를 입력하세요.",
                                placeHolder: "인증 코드",
                                notificationText: "",
                                changeText: "코드를 받지 못했습니다.",
                                exitText: "이미 계정이 있으신가요?")
        case .phoneNumberVerfication:
            return JoinViewText(title: "인증 코드 입력",
                                content: "계정을 확인하려면 %s로 전송된 6자리 코드를 입력하세요.",
                                placeHolder: "인증 코드",
                                notificationText: "",
                                changeText: "코드를 받지 못했습니다.",
                                exitText: "이미 계정이 있으신가요?")
        case .passwordGenerator:
            return JoinViewText(title: "비밀번호 만들기",
                                content: "다른 사람이 추측할 수 없는 6자 이상의 문자 또는 숫자로 비밀번호를 만드세요.",
                                placeHolder: "비밀번호",
                                notificationText: "",
                                changeText: "",
                                exitText: "이미 계정이 있습니다")
        }

    }
    
    func popupText(_ style: JoinViewController.PopUpStyle)-> PopUpText{
        switch style {
        case .login:
            return PopUpText(title: "이미 계정이 있으신가요?", message: nil)
        case .cancel:
            return PopUpText(title: "계정 만들기를 중단하시겠어요?", message: "지금 중단하면 진행된 내용이 모두 삭제됩니다.")
        }
    }
    
    func actionText(_ action: PopUpAction)-> String{
        switch action{
        case .login:
            return "로그인"
        case .stop:
            return "계정 만들기 중단"
        case .cancel:
            return "계정 계속 만들기"
        case .resendVerficationCode:
            return "인증 코드 재전송"
        case .changeEmailAddress:
            return "이메일 주소 변경"
        case .phoneNumberVerfication:
            return "휴대폰 번호로 확인"
        }
    }
}
