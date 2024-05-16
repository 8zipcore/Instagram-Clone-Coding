//
//  JoinViewController.swift
//  Instagram
//
//  Created by 홍승아 on 4/17/24.
//

import UIKit

class JoinViewController: UIViewController {
    
    enum ViewType{
        case emailJoin
        case phoneNumberJoin
        case emailVerification
        case phoneNumberVerfication
        case passwordGenerator
    }
    
    enum PopUpStyle{
        case login
        case cancel
    }

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var textView: LoginTextView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var nextButton: LoginButton!
    @IBOutlet weak var changeButton: LoginButton!
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var notificationLabelTopConstraint: NSLayoutConstraint!
    var loadingView = JoinVCLoadingView()
    
    var viewType: ViewType?
    var email: String?
    var phoneNumber: String?
    private var joinViewModel = JoinViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addLoadingView()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showLoadingAnimation()
    }
    
    private func addLoadingView(){
        loadingView = JoinVCLoadingView(frame: contentView.frame)
        self.view.addSubview(loadingView)
        self.contentView.alpha = 0
    }
    
    private func configureView(){
        navigationController?.isNavigationBarHidden = true
        
        textView.loginTextViewDelegate = self
        
        contentView.backgroundColor = .clear
        
        titleLabel.textColor = .white
        contentLabel.textColor = .white
        
        titleLabel.font = SDGothicBold(size: 24)
        contentLabel.font = SDGothic(size: 15)
        notificationLabel.font = SDGothic(size: 13)
        
        contentLabel.numberOfLines = 0
        notificationLabel.numberOfLines = 0
        
        notificationLabel.textColor = RGB(red: 203, green: 210, blue: 217)
        
        nextButton.setButton(.blue)
        changeButton.setButton(.lightgray)
        
        exitButton.titleLabel?.font = SDGothic(size: 15)
        exitButton.tintColor = RGB(red: 7, green: 165, blue: 250)
        
        setText()
    }
        
    private func setText(){
        guard let viewType = viewType else { debugPrint("VieType Error"); return }
        
        let joinViewText = joinViewModel.text(viewType)
                
        titleLabel.text = joinViewText.title
        contentLabel.text = joinViewText.content
        
        textView.setPlaceHolderLabelText(joinViewText.title)
        textView.setButtonImage(viewType == .passwordGenerator ?
                                UIImage(systemName: "eye.slash")! : UIImage(systemName: "xmark")!)
        textView.setButtonHidden(true)
        
        if joinViewText.notificationText.count == 0{
            notificationLabel.isHidden = true
            notificationLabelTopConstraint.constant = 5
        }
        notificationLabel.text = joinViewText.notificationText
        
        nextButton.setTitle("다음", for: .normal)
        
        changeButton.isHidden = joinViewText.changeText.count == 0
        changeButton.setTitle(joinViewText.changeText, for: .normal)
        
        exitButton.setTitle(joinViewText.exitText, for: .normal)
    }
}

extension JoinViewController{
    private func showLoadingAnimation(){
        UIView.animate(withDuration: 0.15, animations:{
            self.loadingView.alpha = 0
            self.contentView.alpha = 1
        }, completion: { _ in
            self.loadingView.removeFromSuperview()
        })
    }
    
    private func showPopUpViewController(style: PopUpStyle){
        let popupVC = PopUpViewController()
        popupVC.modalPresentationStyle = .overCurrentContext
        let popupText = joinViewModel.popupText(style)
        popupVC.setText(title: popupText.title, message: popupText.message)
        switch style{
        case .login:
            popupVC.addButton(joinViewModel.actionText(.login), {
                self.navigationController?.popToRootViewController(animated: true)
            })
        case .cancel:
            popupVC.addButton(joinViewModel.actionText(.stop), {
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
        popupVC.addButton(joinViewModel.actionText(.cancel))
        self.present(popupVC, animated: false)
    }
}

extension JoinViewController{
    @IBAction func backButtonTapped(_ sender: Any) {
        guard let viewType = viewType else { debugPrint("ViewType Error"); return }
        switch viewType{
        case .emailJoin: fallthrough
        case .phoneNumberJoin:
            showPopUpViewController(style: .cancel)
        case .emailVerification: fallthrough
        case .phoneNumberVerfication: fallthrough
        case .passwordGenerator:
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let viewType = viewType else { debugPrint("ViewType Error"); return }
        
        if viewType == .passwordGenerator {
            return
        }
        
        let joinVC = JoinViewController()
        
        switch viewType{
        case .emailJoin:
            joinVC.viewType = .emailVerification
            joinVC.email = ""
        case .phoneNumberJoin:
            joinVC.viewType = .phoneNumberVerfication
            joinVC.phoneNumber = ""
        case .emailVerification: fallthrough
        case .phoneNumberVerfication:
            joinVC.viewType = .passwordGenerator
        case .passwordGenerator:
            break
        }
        
        self.navigationController?.pushViewController(joinVC, animated: true)
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        guard let viewType = viewType else { debugPrint("VieType Error"); return }
        
        if viewType == .passwordGenerator {
            return
        }
        
        switch viewType{
        case .emailJoin:
            let joinVC = JoinViewController()
            joinVC.viewType = .phoneNumberJoin
            self.navigationController?.pushViewController(joinVC, animated: true)
        case .phoneNumberJoin:
            let joinVC = JoinViewController()
            joinVC.viewType = .emailJoin
            self.navigationController?.popViewController(animated: false)
            self.navigationController?.pushViewController(joinVC, animated: true)
        case .emailVerification:
            let verificationVC = VerificationPopUpViewController()
            verificationVC.addButton(joinViewModel.actionText(.resendVerficationCode), {
                
            })
            verificationVC.addButton(joinViewModel.actionText(.changeEmailAddress), {
                
            })
            verificationVC.addButton(joinViewModel.actionText(.phoneNumberVerfication), {
                
            })
            self.present(verificationVC, animated: true)
            break
        case .phoneNumberVerfication:
            break
        case .passwordGenerator:
            break
        }
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        showPopUpViewController(style: .login)
    }
}

extension JoinViewController: LoginTextViewDelegate{
    func textFieldDidChange(_ sender: LoginTextView) {
        let textCount = sender.inputTextField.text?.count ?? 0
        textView.setButtonHidden(textCount == 0)
    }
    
    func textFieldDidEndEditing(_ sender: LoginTextView) {
        textView.setButtonHidden(true)
    }
    
    func buttonTapped(_ sender: LoginTextView) {
        textView.resetTextField()
    }
}
