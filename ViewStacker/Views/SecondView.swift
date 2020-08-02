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
            headerLabel.alpha = 0
            switch currentState {
            case .Dismissed:
                
                headerLabel.alpha = 1
                navigationDelegate?.dismissCurrentView()
                break
            case .Visible:
                navigationDelegate?.moveForward()
                break
            case .FullScreen:
                break
            default:
                break
            }
        }
    }
    
    
    
    //App related properties
    var headerLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerLabel = UILabel()
        self.addSubview(headerLabel)
        headerLabel.text = "Proceed to EMI selection"
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        [headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
         headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}



extension SecondView: StackViewDimensionProtocol{
    func recieveIncomingData(value: Any?) {
    }
    
    func sendDataToNextView() -> Any? {
        return 80
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


extension SecondView{
    
    
    func initViews(){
        
        
        
    }
}
