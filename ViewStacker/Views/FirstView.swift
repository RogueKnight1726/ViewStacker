//
//  FirstView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


class FirstView: UIView{
    
    let backgroundTemplate = BaseView.init(with: UIColor(red: 0.07, green: 0.10, blue: 0.13, alpha: 1.00), circular: false, shadow: false, borderColor: nil, borderThickness: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backgroundTemplate)
        backgroundTemplate.translatesAutoresizingMaskIntoConstraints = false
        [backgroundTemplate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
         backgroundTemplate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         backgroundTemplate.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
         backgroundTemplate.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({ $0.isActive = true} )
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}



extension FirstView: StackTravesalDelegate{
    func heightOfHeaderView() -> CGFloat {
        return 50
    }
}
