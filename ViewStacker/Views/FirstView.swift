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
            switch currentState {
            case .Dismissed:
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
    var dialContainerView: BaseView!
    var progressDialView: CircularProgressView!
    let progressTrackColor = UIColor(red: 1.00, green: 0.92, blue: 0.88, alpha: 1.00)
    let progressFillColor = UIColor(red: 0.88, green: 0.58, blue: 0.45, alpha: 1.00)
    var panGesture: UIPanGestureRecognizer!
    var panActive = false
    var startingAngle: CGFloat = 0.0
    let headingLabel = UILabel()
    
    
    
    @objc func panDetected(sender: UIPanGestureRecognizer){
        
        if sender.state == .began{
            if abs(distanceBetweenPoints(from: sender.location(in: self), to: dialContainerView.center) - progressDialView.bounds.width) < 20{
                panActive = true
            }
        }
        
        if panActive{
            let referencePoint = CGPoint.init(x: self.frame.width / 2, y: self.frame.width / 2)
            let angleValue = angle(between: referencePoint, ending: sender.location(in: self))
            print("Angle : \(angleValue - startingAngle)")
            startingAngle = angleValue
            
            if angleValue > 350.0{
                sender.state = .ended
            }
            progressDialView.progressValue = Float((angleValue / 350.0))
//            var transform = CGAffineTransform.identity
//            transform = transform.concatenating(CGAffineTransform.init(rotationAngle: angleValue))
//            progressDialView.transform = transform
        }
        
        if sender.state == .ended{
            panActive = false
        }
    }
    
    func angle(between starting: CGPoint, ending: CGPoint) -> CGFloat {
        let center = CGPoint(x: ending.x - starting.x, y: ending.y - starting.y)
        let radians = atan2(center.y, center.x)
        let degrees = radians * 180 / .pi
        let adjustedDegrees = degrees + 90
        return adjustedDegrees > 0 ? adjustedDegrees : 360 + degrees + 90
    }
    
    
    func distanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func distanceBetweenPoints(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(distanceSquared(from: from, to: to))
    }
    
    private func degreesToRadians(_ deg: CGFloat) -> CGFloat {
        return deg * CGFloat.pi / 180
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.subviews.contains(headingLabel) { return }
        initViews()
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



extension FirstView{
    
    
    func initViews(){
        
        self.addSubview(headingLabel)
        headingLabel.text = "Hello SWAT, how much do you need?"
        headingLabel.textColor = AppTheme.cardsControllertextColor
        headingLabel.numberOfLines = 0
        headingLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        [headingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
         headingLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)].forEach({$0.isActive = true})
        
        let instructionLabel = UILabel()
        self.addSubview(instructionLabel)
        instructionLabel.text = "move the dial and set the amount to any amount you need upto ₹7,00,000.00"
        instructionLabel.textColor = AppTheme.textColor
        instructionLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        instructionLabel.numberOfLines = 0
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        [instructionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         instructionLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8),
         instructionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)].forEach({$0.isActive = true})
        
        dialContainerView = BaseView.init(with: .white, circular: false, shadow: false, borderColor: nil, borderThickness: nil)
        self.addSubview(dialContainerView)
        dialContainerView.translatesAutoresizingMaskIntoConstraints = false
        [dialContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
         dialContainerView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
         dialContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -60),
         dialContainerView.heightAnchor.constraint(equalTo: dialContainerView.widthAnchor, constant: 0)].forEach({$0.isActive = true})
        
        progressDialView = CircularProgressView.init(progress: 0.2, trackColor: progressTrackColor, progressColor: progressFillColor)
        dialContainerView.addSubview(progressDialView)
        progressDialView.translatesAutoresizingMaskIntoConstraints = false
        [progressDialView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
         progressDialView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
         progressDialView.centerYAnchor.constraint(equalTo: dialContainerView.centerYAnchor, constant: 0),
         progressDialView.centerXAnchor.constraint(equalTo: dialContainerView.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        
        panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panDetected(sender:)))
        dialContainerView.addGestureRecognizer(panGesture)
        
        let bottomDescriptionLabel = UILabel()
        dialContainerView.addSubview(bottomDescriptionLabel)
        bottomDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        [bottomDescriptionLabel.leftAnchor.constraint(equalTo: dialContainerView.leftAnchor, constant: 20),
         bottomDescriptionLabel.rightAnchor.constraint(equalTo: dialContainerView.rightAnchor, constant: -20),
         bottomDescriptionLabel.bottomAnchor.constraint(equalTo: dialContainerView.bottomAnchor, constant: -20)].forEach({$0.isActive = true})
        bottomDescriptionLabel.numberOfLines = 3
        bottomDescriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        bottomDescriptionLabel.textColor = AppTheme.cardsControllertextColor
        bottomDescriptionLabel.textAlignment = .center
        bottomDescriptionLabel.text = "stash is instant. money will be credited within seconds"
        
//        circularPath = UIBezierPath.init(arcCenter: self.center, radius: self.bounds.width, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
//        circularShape.path = circularPath.cgPath
//        self.layer.addSublayer(circularShape)
    }
}


//extension CGPoint {
//    func angle(to comparisonPoint: CGPoint) -> CGFloat {
//        let originX = comparisonPoint.x - self.x
//        let originY = comparisonPoint.y - self.y
//        let bearingRadians = atan2f(Float(originY), Float(originX))
//        var bearingDegrees = CGFloat(bearingRadians).degrees
//        while bearingDegrees < 0 {
//            bearingDegrees += 360
//        }
//        return bearingDegrees
//    }
//}
//
//extension CGFloat {
//    var degrees: CGFloat {
//        return self * CGFloat(180.0 / .pi)
//    }
//}
