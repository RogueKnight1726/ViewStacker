//
//  HomeController.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import StacksManager

class HomeController: UIViewController{
    
    let productView = StashAmountSelectionView.init(with: UIColor(red: 0.07, green: 0.10, blue: 0.13, alpha: 1.00), circular: false, shadow: false, borderColor: nil, borderThickness: nil)
    let detailView = EMISelectionView.init(with: UIColor(red: 0.09, green: 0.13, blue: 0.17, alpha: 1.00), circular: false, shadow: false, borderColor: nil, borderThickness: nil)
    let actionView = BankDetailsSelectionView.init(with: UIColor(red: 0.11, green: 0.15, blue: 0.19, alpha: 1.00), circular: false, shadow: false, borderColor: nil, borderThickness: nil)
    
    

    var arrayOfScenes: [StackViewDataSource]!
    var currentScene = 0
    
    var stackManager: StackManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfScenes = [productView,detailView,actionView]
        
        
        let button = UIButton.init()
        button.setTitle("Start", for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        [button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
         button.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
        button.addTarget(self, action: #selector(showStackViews(sender:)), for: .touchUpInside)
        
        
        initViews()
    }
    
    
    
    
    
    
    @objc func showStackViews(sender: UIButton){
        let guide = view.safeAreaLayoutGuide
        stackManager = StackManager.init(frame: self.view.frame, viewStack: arrayOfScenes, guide: guide)
        self.view.addSubview(stackManager)
        
    }
}





extension HomeController{
    
    func initViews(){
        
        view.backgroundColor = AppTheme.APP_BACKGROUNDCOLOR
        
    }
}

