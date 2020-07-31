//
//  DragPlaceHolderView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class DragViewPlaceHolderView: UIView{
    
    var handle = UIView()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.addSubview(handle)
        handle.translatesAutoresizingMaskIntoConstraints = false
        [handle.widthAnchor.constraint(equalToConstant: 80),
         handle.heightAnchor.constraint(equalToConstant: 6),
         handle.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
         handle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)].forEach({$0.isActive = true})
        handle.backgroundColor = UIColor(red: 0.73, green: 0.78, blue: 0.81, alpha: 1.00)
        handle.layer.cornerRadius = 3
        handle.clipsToBounds = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
