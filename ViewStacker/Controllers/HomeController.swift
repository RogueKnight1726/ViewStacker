//
//  HomeController.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class HomeController: UIViewController{
    
    let productView = FirstView.init(with: UIColor(red: 0.07, green: 0.10, blue: 0.13, alpha: 1.00), circular: false, shadow: false, borderColor: nil, borderThickness: nil)
    let detailView = SecondView.init(with: UIColor(red: 0.09, green: 0.13, blue: 0.17, alpha: 1.00), circular: false, shadow: false, borderColor: nil, borderThickness: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guide = view.safeAreaLayoutGuide
        
        
        view.addSubview(productView)
        productView.translatesAutoresizingMaskIntoConstraints = false
        [productView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
         productView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
         productView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
         productView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 20)].forEach({$0.isActive = true})
        productView.navigationDelegate = self
        
        view.addSubview(detailView)
        print("Profuct View Top : \(productView.heightOfHeaderView())")
        detailView.translatesAutoresizingMaskIntoConstraints = false
        [detailView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        detailView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        detailView.topAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
        detailView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0)].forEach({$0.isActive = true})
        detailView.navigationDelegate = self
        getHeightOfHeader()
    }
    
    
    func getHeightOfHeader(){
        let heightOfFirstView = productView.heightOfHeaderView()
        print("View height : \(heightOfFirstView)")
    }
}


extension HomeController: StackNavigationProtocol{
    func moveForward(with dataSet: Any?) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let _ = self else { return }
            let guide = self!.view.safeAreaLayoutGuide
            self!.detailView.transform = CGAffineTransform.init(translationX: 0, y: -(guide.layoutFrame.size.height - self!.productView.heightOfHeaderView()))
        }, completion: nil)
        
    }
    
    func dismissCurrentView() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let _ = self else { return }
            self!.detailView.transform = .identity
        }, completion: nil)
        
    }
    
    
}



