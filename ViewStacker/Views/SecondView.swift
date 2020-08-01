//
//  SecondView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import StacksManager


class SecondView: BaseView{
    
    weak var navigationDelegate: StackNavigationProtocol?
    
    public var currentState: ViewState!{
        didSet{
            print("New Value Set")
            navigationDelegate?.dismissCurrentView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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



extension SecondView: StackViewDimensionProtocol{
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
