//
//  VerificationPopUpViewController.swift
//  Instagram
//
//  Created by 홍승아 on 4/26/24.
//

import UIKit

class VerificationPopUpViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    private var buttonTitleArray: [String] = []
    private var buttonActionArray: [() -> Void] = []
    
    private var cellHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 15
        tableView.isScrollEnabled = false
        
        tableView.register(VerificationPopUpTableViewCell.self, forCellReuseIdentifier: VerificationPopUpTableViewCell.identifier)
        
        let verticalGradientLayer = CAGradientLayer()
        verticalGradientLayer.frame = view.bounds
        let verticalColors: [CGColor] = [
            RGB(red: 22, green: 42, blue: 56).cgColor,
            RGB(red: 28, green: 56, blue: 55).cgColor
        ]
        verticalGradientLayer.colors = verticalColors
        verticalGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        verticalGradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        verticalGradientLayer.locations = [0.65]
        backgroundView.layer.addSublayer(verticalGradientLayer)
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.clipsToBounds = true
        
        tableViewHeightConstraint.constant = cellHeight * CGFloat(buttonTitleArray.count)
    }
    
    func addButton(_ title: String, _ action:@escaping () -> Void){
        buttonTitleArray.append(title)
        buttonActionArray.append(action)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension VerificationPopUpViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VerificationPopUpTableViewCell.identifier, for: indexPath) as? VerificationPopUpTableViewCell else { return UITableViewCell() }
        cell.updateUI(buttonTitleArray[indexPath.item], indexPath.item == 0)
        return cell
    }
}

extension VerificationPopUpViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buttonActionArray[indexPath.item]()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
