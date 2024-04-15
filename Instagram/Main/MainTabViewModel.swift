//
//  MainTabViewModel.swift
//  Instagram
//
//  Created by 홍승아 on 3/29/24.
//

import Foundation
import UIKit

class MainTabViewModel{
    
    private var mainTabItems: [MainTabItem]{
        return [ .home, .search, .upload, .reels, .profile]
    }
    
    func mainTabItemsCount()-> Int{
        return mainTabItems.count
    }
    
    /*
    func mainTabItemImage(_ index: Int)-> UIImage{
        
        
        var imageName = "MainTab" +  + "Icon"
        return UIImage(named: imageName)
    }
     */
}

