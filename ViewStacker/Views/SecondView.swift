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
        
//        self.addSubview(backgroundTemplate)
//        backgroundTemplate.translatesAutoresizingMaskIntoConstraints = false
//        [backgroundTemplate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
//         backgroundTemplate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
//         backgroundTemplate.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//         backgroundTemplate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({ $0.isActive = true} )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}



extension SecondView: StackViewDimensionProtocol{
    
    
    
    func heightOfHeaderView() -> CGFloat {
        return 50
    }
    
    
    
}
