//
//  FirstView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import StacksManager


class FirstView: BaseView{
    
    weak var navigationDelegate: StackNavigationProtocol?
    public var currentState: ViewState!{
        didSet{
            navigationDelegate?.dismissCurrentView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.addSubview(backgroundTemplate)
//        backgroundTemplate.translatesAutoresizingMaskIntoConstraints = false
//        [backgroundTemplate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
//         backgroundTemplate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
//         backgroundTemplate.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//         backgroundTemplate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({ $0.isActive = true} )
        let label = UILabel()
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        [label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
         label.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)].forEach({$0.isActive = true})
        label.text = "Hello World"
        
        let proceedButton = UIButton.init()
        self.addSubview(proceedButton)
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        [proceedButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
         proceedButton.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
        proceedButton.addTarget(self, action: #selector(proceedToDetail(sender:)), for: .touchUpInside)
        proceedButton.setTitle("Proceed", for: .normal)
        
    }
    
    
    @objc func proceedToDetail(sender: UIButton){
        navigationDelegate?.moveForward(with: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}

extension FirstView: StackViewDimensionProtocol{
    
    var state: ViewState {
        get {
            return currentState
        }
        set {
            self.currentState = newValue
        }
    }
    
    
    
    func heightOfHeaderView() -> CGFloat {
        return 100
    }
}

