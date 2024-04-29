//
//  Color.swift
//  Instagram
//
//  Created by 홍승아 on 4/2/24.
//

import UIKit

public func RGB(red: Int, green: Int, blue: Int)-> UIColor{
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
}

public func RGB(red: Int, green: Int, blue: Int, alpha: CGFloat)-> UIColor{
    return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
}

extension UIColor{
    
}
