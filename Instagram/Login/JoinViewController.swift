//
//  JoinViewController.swift
//  Instagram
//
//  Created by 홍승아 on 4/17/24.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var emailTextView: LoginTextView!
    @IBOutlet weak var nextButton: LoginButton!
    @IBOutlet weak var cpJoinButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureView()
    }
    
    private func configureView(){
        navigationController?.isNavigationBarHidden = true
        
        titleLabel.textColor = .white
        contentLabel.textColor = .white
        
        titleLabel.font = SDGothicBold(size: 24)
        contentLabel.font = SDGothic(size: 15)
        
        contentLabel.numberOfLines = 0
        
        titleLabel.text = "이메일 주소 입력"
        contentLabel.text = "회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다."
        
        emailTextView.loginTextViewDelegate = self
        
        emailTextView.setPlaceHolderLabelText("이메일 주소")
        emailTextView.setButtonImage(UIImage(systemName: "xmark")!)
        emailTextView.setButtonHidden(true)
        
        nextButton.setTitle("다음", for: .normal)
        cpJoinButton.setTitle("휴대폰 번호로 가입", for: .normal)
        
        nextButton.setButton(.blue)
        cpJoinButton.setButton(.lightgray)
    }


    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension JoinViewController: LoginTextViewDelegate{
    func textFieldDidChange(_ sender: LoginTextView) {
        let textCount = sender.inputTextField.text?.count ?? 0
        emailTextView.setButtonHidden(textCount == 0)
    }
    
    func textFieldDidEndEditing(_ sender: LoginTextView) {
        emailTextView.setButtonHidden(true)
    }
    
    func buttonTapped(_ sender: LoginTextView) {
        emailTextView.resetTextField()
    }
}
