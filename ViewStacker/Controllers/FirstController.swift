//
//  FirstController.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit



//Controller to check if memory leaks are happening
class FirstController: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.init()
        button.setTitle("Start", for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        [button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
         button.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
        button.addTarget(self, action: #selector(showStackViews(sender:)), for: .touchUpInside)
    }
    
    @objc func showStackViews(sender: UIButton){
        let vc = HomeController()
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
