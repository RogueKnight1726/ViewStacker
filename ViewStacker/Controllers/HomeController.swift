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
    let actionView = ThirdView.init(with: UIColor(red: 0.11, green: 0.15, blue: 0.19, alpha: 1.00), circular: false, shadow: false, borderColor: nil, borderThickness: nil)

    var arrayOfScenes: [StackViewDimensionProtocol]!
    var currentScene = 0
    
    var stackManager = StackManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guide = view.safeAreaLayoutGuide
        arrayOfScenes = [productView,detailView,actionView]
        stackManager.initiateGestureRecogniser()
        stackManager.arrayOfViews = arrayOfScenes
        stackManager.addDismissGestureToAllViews()
        stackManager.guide = guide
        
        let button = UIButton.init()
        button.setTitle("Start", for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        [button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
         button.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
        button.addTarget(self, action: #selector(showStackViews(sender:)), for: .touchUpInside)
        
        
        
    }
    
    
    @objc func showStackViews(sender: UIButton){
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(productView)
        productView.translatesAutoresizingMaskIntoConstraints = false
        [productView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        productView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        productView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0),
        productView.topAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        productView.navigationDelegate = stackManager
        
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        [detailView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        detailView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        detailView.topAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
        detailView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0)].forEach({$0.isActive = true})
        detailView.navigationDelegate = stackManager
        
        
        view.addSubview(actionView)
        actionView.translatesAutoresizingMaskIntoConstraints = false
        [actionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
        actionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        actionView.topAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0),
        actionView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0)].forEach({$0.isActive = true})
        actionView.navigationDelegate = stackManager
        
        stackManager.performInitialAnimation()
    }
}


//extension HomeController: StackNavigationProtocol{
//    func moveForward(with dataSet: Any?) {
//        
//        switch currentScene{
//        case 0:
//            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
//                guard let _ = self else { return }
//                let guide = self!.view.safeAreaLayoutGuide
//                self!.detailView.transform = CGAffineTransform.init(translationX: 0, y: -(guide.layoutFrame.size.height - self!.productView.heightOfHeaderView()))
//            }, completion: nil)
//            break
//        case 1:
//            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
//                guard let _ = self else { return }
//                let guide = self!.view.safeAreaLayoutGuide
//                var offsetValue: CGFloat! = 0
//                for i in 0...self!.currentScene{
//                    offsetValue = offsetValue + self!.arrayOfScenes[i].heightOfHeaderView()
//                }
//                self!.actionView.transform = CGAffineTransform.init(translationX: 0, y: -(guide.layoutFrame.size.height - offsetValue))
//            }, completion: nil)
//            break
//        case 3:
//            break
//        default:
//            break
//        }
//        currentScene += 1
//    }
//    
//    func dismissCurrentView() {
//        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
//            guard let _ = self else { return }
//            self!.arrayOfScenes[self!.currentScene].transform = .identity
//        }, completion: nil)
//        
//        currentScene -= 1
//    }
//    
//    
//}



