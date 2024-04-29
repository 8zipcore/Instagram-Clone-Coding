//
//  LoginNavigationViewController.swift
//  Instagram
//
//  Created by 홍승아 on 4/23/24.
//

import UIKit

class LoginNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    private func configureView(){
        let backgroundView = UIView(frame: self.view.frame)
        
        view.addSubview(backgroundView)
        view.sendSubviewToBack(backgroundView)
        
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
