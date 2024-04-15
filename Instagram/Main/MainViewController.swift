//
//  MainViewController.swift
//  Instagram
//
//  Created by 홍승아 on 3/29/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var mainTabCollectionView: UICollectionView!
    
    private let mainTabViewModel = MainTabViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
}

extension MainViewController {
    private func configureView(){
        configureMainTabCollectionView()
        
        view.addSubview(mainTabCollectionView)
        
        mainTabCollectionView.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(self.view.bounds.height * 0.071) // height 비율 고민 ****
        }
        
        mainTabCollectionView.backgroundColor = .red
    }
    
    private func configureMainTabCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        mainTabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        mainTabCollectionView.backgroundColor = .clear
        // mainTabCollectionView.contentINset = UIEdgeInsets(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
        mainTabCollectionView.translatesAutoresizingMaskIntoConstraints = false
        registerMainTabCollectionViewCell()
    }
    
    private func registerMainTabCollectionViewCell(){
        let mainTabCollectionViewCellNib = UINib(nibName: MainTabCollectionViewCell.identifier, bundle: nil)
        mainTabCollectionView.register(mainTabCollectionViewCellNib, forCellWithReuseIdentifier: MainTabCollectionViewCell.identifier)
    }
}

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainTabViewModel.mainTabItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainTabCollectionView.dequeueReusableCell(withReuseIdentifier: MainTabCollectionViewCell.identifier, for: indexPath) as? MainTabCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let superView = mainTabCollectionView.bounds.size
        
        return CGSize(width: superView.width / 5, height: superView.height)
    }
}
