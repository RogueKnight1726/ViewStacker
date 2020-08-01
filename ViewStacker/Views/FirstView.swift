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
        
    }
    
    
    @objc func proceedToDetail(sender: UIButton){
        navigationDelegate?.moveForward()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}

extension FirstView: StackViewDimensionProtocol{
    func recieveIncomingData(value: Any?) {
        
    }
    
    func sendDataToNextView() -> Any? {
        return 30
    }
    
    
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

