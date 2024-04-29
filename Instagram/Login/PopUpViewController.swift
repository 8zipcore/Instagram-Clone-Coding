//
//  PopUpViewController.swift
//  Instagram
//
//  Created by 홍승아 on 4/22/24.
//

import UIKit

class PopUpViewController: UIViewController{

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionTableView: UITableView!
    
    @IBOutlet weak var actionTableViewHeightConstraint: NSLayoutConstraint!

    private var titleLabelText: String = ""
    private var messageLabelText: String?
    private var buttonTitleArray: [String] = []
    private var buttonActionArray: [() -> Void] = []
    
    private let cellHeight:CGFloat = 50
    private let cornerRadius: CGFloat = 15

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addBlurEffect()
        presentAnimation()
    }
    
    private func configureView(){
        view.backgroundColor = .clear
        backgroundView.backgroundColor = RGB(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        popupView.backgroundColor = .clear
        popupView.layer.cornerRadius = cornerRadius
        popupView.clipsToBounds = true
        
        titleLabel.font = SDGothicBold(size: 18)
        messageLabel.font = SDGothic(size: 14)
        
        titleLabel.textColor = .white
        messageLabel.textColor = .white
        
        titleLabel.text = titleLabelText
        
        if let message = messageLabelText{
            messageLabel.text = message
        } else {
            
        }
        
        titleLabel.numberOfLines = 0
        messageLabel.numberOfLines = 0
        
        actionTableView.backgroundColor = .clear
        
        actionTableView.delegate = self
        actionTableView.dataSource = self
        
        actionTableView.register(ActionTableViewCell.self, forCellReuseIdentifier: ActionTableViewCell.identifier)
        actionTableView.isScrollEnabled = false
        
        actionTableViewHeightConstraint.constant = CGFloat(buttonTitleArray.count) * cellHeight
        
        actionTableView.clipsToBounds = true
        
        popupView.alpha = 0
    }
    
    private func addBlurEffect(){
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = popupView.bounds
        visualEffectView.layer.cornerRadius = cornerRadius
        visualEffectView.clipsToBounds = true
        popupView.addSubview(visualEffectView)
        popupView.sendSubviewToBack(visualEffectView)
    }
    
    func setText(title: String, message: String?){
        titleLabelText = title
        messageLabelText = message
    }
    
    func addButton(_ title: String){
        buttonTitleArray.append(title)
        buttonActionArray.append({})
    }
    
    func addButton(_ title: String, _ action:@escaping () -> Void){
        buttonTitleArray.append(title)
        buttonActionArray.append(action)
    }
    
}

extension PopUpViewController{
    private func presentAnimation(){
        popupView.transform = CGAffineTransform(scaleX: 1.16, y: 1.16)
        UIView.animate(withDuration: 0.13, animations: {
            self.popupView.transform = CGAffineTransform.identity
            self.popupView.alpha = 1
        })
    }
    
    func dismiss(){
        UIView.animate(withDuration: 0.13, animations: {
            self.popupView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first , touch.view == backgroundView{
            self.dismiss()
        }
    }
}

extension PopUpViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = actionTableView.dequeueReusableCell(withIdentifier: ActionTableViewCell.identifier, for: indexPath) as? ActionTableViewCell else { return UITableViewCell() }
        cell.updateUI(buttonTitleArray[indexPath.row], indexPath.item == 0)
        return cell
    }
}

extension PopUpViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buttonActionArray[indexPath.item]()
        self.dismiss()
    }
}
