//
//  LoginViewController.swift
//  Instagram
//
//  Created by 홍승아 on 4/2/24.
//

import UIKit

class LoginViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var idTextView: LoginTextView!
    @IBOutlet weak var pwTextView: LoginTextView!
    @IBOutlet weak var loginButton: LoginButton!
    @IBOutlet weak var findPWButton: UIButton!
    @IBOutlet weak var joinButton: LoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureView()
    }
    
    private func configureView(){
        navigationController?.delegate = self
        
        idTextView.loginTextViewDelegate = self
        pwTextView.loginTextViewDelegate = self
        
        idTextView.setPlaceHolderLabelText("사용자 이름, 이메일 주소 또는 휴대폰 번호")
        pwTextView.setPlaceHolderLabelText("비밀번호")
        
        idTextView.setButtonImage(UIImage(systemName: "xmark")!)
        pwTextView.setButtonImage(UIImage(systemName: "eye.slash")!)
        
        idTextView.setButtonHidden(true)
        pwTextView.setButtonHidden(true)
        
        pwTextView.secureTextEntryToggle()
        
        loginButton.setTitle("로그인", for: .normal)
        joinButton.setTitle("새 계정 만들기", for: .normal)
        
        loginButton.setButton(.blue)
        joinButton.setButton(.lightblue)

    }

    @IBAction func joinButtonTapped(_ sender: Any) {
        let joinVC = JoinViewController()
        self.navigationController?.pushViewController(joinVC, animated: true)
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation{
        case .none:
            return nil
        case .push:
            return LoginPushAnimation()
        case .pop:
            return LoginPopAnimation()
        @unknown default:
            return nil
        }
       
    }
    
}

extension LoginViewController: LoginTextViewDelegate{
    func textFieldDidChange(_ sender: LoginTextView) {
        let textCount = sender.inputTextField.text?.count ?? 0
        
        switch sender{
        case idTextView:
            idTextView.setButtonHidden(textCount == 0)
            break
        case pwTextView:
            pwTextView.setButtonHidden(textCount == 0)
            break
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ sender: LoginTextView) {
        switch sender{
        case idTextView:
            idTextView.setButtonHidden(true)
            break
        case pwTextView:
            // pwTextView.trailingButton.isHidden = true
            break
        default:
            break
        }
    }
    
    func buttonTapped(_ sender: LoginTextView) {
        switch sender{
        case idTextView:
            idTextView.resetTextField()
            break
        case pwTextView:
            pwTextView.secureTextEntryToggle()
            let imageName = pwTextView.isSecureTextEntry() ? "eye.slash" : "eye"
            pwTextView.setButtonImage(UIImage(systemName: imageName)!)
            break
        default:
            break
        }
    }
}
