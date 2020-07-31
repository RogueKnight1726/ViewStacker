//
//  HomeController.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class HomeController: UIViewController{
    
    let productView = FirstView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guide = view.safeAreaLayoutGuide
        
        
        view.addSubview(productView)
        productView.translatesAutoresizingMaskIntoConstraints = false
        [productView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         productView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         productView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
         productView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20)].forEach({$0.isActive = true})
        getHeightOfHeader()
    }
    
    
    func getHeightOfHeader(){
        let heightOfFirstView = productView.heightOfHeaderView()
        print("View height : \(heightOfFirstView)")
    }
}



protocol StackViewDimensionProtocol: UIView{
    func heightOfHeaderView() -> CGFloat
}


protocol StackNavigationProtocol: AnyObject{
    
    func moveForward(with dataSet: Any)
}
