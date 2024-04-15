//
//  LoginTextField.swift
//  Instagram
//
//  Created by 홍승아 on 4/2/24.
//

import UIKit
import SnapKit

protocol LoginTextViewDelegate {
    func textFieldDidChange(_ sender: LoginTextView)
    func textFieldDidEndEditing(_ sender: LoginTextView)
    func buttonTapped(_ sender: LoginTextView)
}

class LoginTextView: UIView {
    
    enum Color{
        case background
        case border
        case clickedBorder
        case placeholder
        case textfield
    }
    
    var inputTextField = UITextField()
    var placeHolderLabel = UILabel()
    var smallPlaceHolderLabel = UILabel()
    var trailingButton = UIButton()
    
    var loginTextViewDelegate: LoginTextViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView(){
        
        self.backgroundColor = color(.background)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.layer.borderColor = color(.border).cgColor
        self.layer.borderWidth = 1.5
        
        placeHolderLabel.textColor = color(.placeholder)
        placeHolderLabel.font = SDGothic(size: 16)
        placeHolderLabel.adjustsFontSizeToFitWidth = true

        smallPlaceHolderLabel.textColor = color(.placeholder)
        smallPlaceHolderLabel.font = SDGothic(size: 14)
        smallPlaceHolderLabel.adjustsFontSizeToFitWidth = true
        
        inputTextField.delegate = self
        inputTextField.textColor = color(.textfield)
        inputTextField.tintColor = color(.textfield)
        
        trailingButton.tintColor = .white
        trailingButton.addTarget(self, action: #selector(trailingButtonTapped(_:)), for: .touchUpInside)
        
//        placeHolderLabel.backgroundColor = .green
//        smallPlaceHolderLabel.backgroundColor = .green
//        trailingButton.backgroundColor = .red
//        inputTextField.backgroundColor = .yellow
        
        self.addSubview(placeHolderLabel)
        self.addSubview(smallPlaceHolderLabel)
        self.addSubview(trailingButton)
        self.addSubview(inputTextField)
        
        let horizonalMargin = self.bounds.size.width * 0.04
        let verticalMargin = self.bounds.size.height * 0.18
        
        placeHolderLabel.snp.makeConstraints{ make in
            make.leading.equalTo(self).inset(horizonalMargin)
            make.trailing.equalTo(self).inset(horizonalMargin)
            make.centerY.equalToSuperview()
        }
        
        trailingButton.snp.makeConstraints{ make in
            make.leading.equalTo(inputTextField.snp.trailing).offset(10)
            make.trailing.equalTo(self).inset(horizonalMargin)
            make.centerY.equalToSuperview()
        }
        
        smallPlaceHolderLabel.snp.makeConstraints{ make in
            make.top.equalTo(self).inset(verticalMargin)
            make.leading.equalTo(self).inset(horizonalMargin)
            make.trailing.equalTo(self).inset(horizonalMargin)
        }
        
        inputTextField.snp.makeConstraints{ make in
            make.top.greaterThanOrEqualTo(smallPlaceHolderLabel.snp.top).inset(5)
            make.bottom.equalTo(self).inset(verticalMargin)
            make.leading.equalTo(smallPlaceHolderLabel)
            make.width.equalTo(self.bounds.size.width * 0.8)
        }
        
        smallPlaceHolderLabel.isHidden = true
    }
    
    private func color(_ color: Color)-> UIColor{
        switch color {
        case .background:
            return RGB(red: 28, green: 43, blue: 51)
        case .border:
            return RGB(red: 70, green: 90, blue: 105)
        case .clickedBorder:
            return RGB(red: 133, green: 149, blue: 164)
        case .placeholder:
            return RGB(red: 116, green: 127, blue: 134)
        case .textfield:
            return .white
        }
    }
}

extension LoginTextView{
    func resetTextField(){
        inputTextField.text = ""
    }
        
    func setPlaceHolderLabelText(_ text: String){
        placeHolderLabel.text = text
        setSmallPlaceHolderLabelText(text)
    }
    
    func setSmallPlaceHolderLabelText(_ text: String){
        smallPlaceHolderLabel.text = text
    }
    
    func setButtonImage(_ image: UIImage){
        trailingButton.setImage(image, for: .normal)
    }
    
    func setBorderColor(_ clicked: Bool){
        self.layer.borderColor = color(clicked ? .clickedBorder : .border).cgColor
    }
    
    func setButtonHidden(_ isHidden: Bool){
        trailingButton.isHidden = isHidden
    }
    
    func secureTextEntryToggle(){
        inputTextField.isSecureTextEntry.toggle()
    }
    
    func isSecureTextEntry() -> Bool {
        return inputTextField.isSecureTextEntry
    }

}

extension LoginTextView: UITextFieldDelegate{
    
    private func placeHolderAnimation(){
        placeHolderLabel.isHidden = true
        
        UIView.animate(withDuration: 0.5, animations: {
            self.smallPlaceHolderLabel.isHidden = false
        })
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        loginTextViewDelegate?.textFieldDidChange(self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        placeHolderAnimation()
        setBorderColor(true)
        
        loginTextViewDelegate?.textFieldDidChange(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setBorderColor(false)
        
        loginTextViewDelegate?.textFieldDidEndEditing(self)
    }
}

extension LoginTextView{
    @objc func trailingButtonTapped(_ sender: Any){
        loginTextViewDelegate?.buttonTapped(self)
    }
}
