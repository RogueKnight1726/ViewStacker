//
//  SecondView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


class SecondView: SwipableBaseView{
    
    weak var navigationDelegate: StackNavigationProtocol?
    
    override var state: ViewState!{
        didSet{
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
    
    
    
    func heightOfHeaderView() -> CGFloat {
        return 100
    }
    
    
    
}
