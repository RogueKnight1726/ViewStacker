//
//  SecondView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import StacksManager


class EMISelectionView: BaseView{
    
    weak var navigationDelegate: StackNavigationProtocol?
    public var currentState: ViewState!{
        didSet{
            headerLabel.alpha = 0
            emiLabel.alpha = 0
            emiValueLabel.alpha = 0
            repayOptionHeadingLabel.alpha = 0
            repayDescriptionLabel.alpha = 0
            duratinLabel.alpha = 0
            durationValuelabel.alpha = 0
            
            switch currentState {
            case .Dismissed:
                headerLabel.alpha = 1
//                navigationDelegate?.dismissCurrentView()
                break
            case .Visible:
//                navigationDelegate?.moveForward()
                repayOptionHeadingLabel.alpha = 1
                repayDescriptionLabel.alpha = 1
                break
            case .FullScreen:
                break
            case .Background:
                emiLabel.alpha = 1
                emiValueLabel.alpha = 1
                duratinLabel.alpha = 1
                durationValuelabel.alpha = 1
                break
            default:
                break
            }
        }
    }
    
    
    //App related properties
    var headerLabel: UILabel!
    var emiLabel: UILabel!
    var emiValueLabel: UILabel!
    
    var duratinLabel: UILabel!
    var durationValuelabel: UILabel!
    var layout: UICollectionViewFlowLayout!
    var collectionView: UICollectionView!
    var colorSet = [AppTheme.cellOneColor,AppTheme.cellTwoColor,AppTheme.cellThreeColor,AppTheme.cellFourColor]
    var modelArray: [EMIModel]?{
        didSet{
            self.collectionView.reloadData()
            if !(modelArray?.isEmpty ?? true){
                self.collectionView.selectItem(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .left)
                self.selectedModel = modelArray?[0]
            }
            
        }
    }
    var createPlanBaseView: BaseView!
    var repayOptionHeadingLabel: UILabel!
    var repayDescriptionLabel: UILabel!
    var selectedModel: EMIModel?{
        didSet{
            self.emiValueLabel.text = "\(selectedModel?.amountToBePaid ?? 0)/month"
            self.durationValuelabel.text = "\(selectedModel?.duration ?? 0) months"
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    //This method is implemented to reduce the number of repeatations while randoming. It doesnt completely remove repeatation, but greatly reduces, and I'm happy with the output
    func randomAndRemove()->UIColor{
        if colorSet.isEmpty {
            colorSet = [AppTheme.cellOneColor,AppTheme.cellTwoColor,AppTheme.cellThreeColor,AppTheme.cellFourColor]
        }
        let color = colorSet.randomElement()
        colorSet.removeAll(where: { $0 == color })
        return color!
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}


extension EMISelectionView: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SomeIdentifier", for: indexPath) as! EmiDistributionCell
        cell.backColor = colorSet[indexPath.row]
        cell.model = modelArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedModel = modelArray?[indexPath.row]
    }
}



extension EMISelectionView: StackViewDataSource{
    func recieveIncomingData(value: Any?) {
        if let valueArray = value as? [EMIModel]{
            self.modelArray = valueArray
        }
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


extension EMISelectionView{
    
    
    func initViews(){
        
        headerLabel = UILabel()
        self.addSubview(headerLabel)
        headerLabel.text = "Proceed to EMI selection"
        headerLabel.textColor = .white
        headerLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        [headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
         headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        
        repayOptionHeadingLabel = UILabel()
        self.addSubview(repayOptionHeadingLabel)
        repayOptionHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        [repayOptionHeadingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         repayOptionHeadingLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
         repayOptionHeadingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)].forEach({$0.isActive = true})
        repayOptionHeadingLabel.text = "how do you wish to repay?"
        repayOptionHeadingLabel.textColor = AppTheme.emiOptionsViewLabelColor
        repayOptionHeadingLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        repayOptionHeadingLabel.alpha = 0
        
        repayDescriptionLabel = UILabel()
        self.addSubview(repayDescriptionLabel)
        repayDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        [repayDescriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         repayDescriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
         repayDescriptionLabel.topAnchor.constraint(equalTo: repayOptionHeadingLabel.bottomAnchor, constant: 14)].forEach({$0.isActive = true})
        repayDescriptionLabel.text = "choose one of our recommended plans or make your own"
        repayDescriptionLabel.textColor = AppTheme.emiOptionsViewLabelColor
        repayDescriptionLabel.numberOfLines = 3
        repayDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        repayDescriptionLabel.alpha = 0
        
        
        
        emiLabel = UILabel()
        self.addSubview(emiLabel)
        emiLabel.text = "EMI"
        emiLabel.textColor = .white
        emiLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        emiLabel.translatesAutoresizingMaskIntoConstraints = false
        [emiLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
         emiLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)].forEach({$0.isActive = true})
        emiLabel.alpha = 0
        
        emiValueLabel = UILabel()
        self.addSubview(emiValueLabel)
        emiValueLabel.text = ""
        emiValueLabel.textColor = .white
        emiValueLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        emiValueLabel.translatesAutoresizingMaskIntoConstraints = false
        [emiValueLabel.topAnchor.constraint(equalTo: emiLabel.bottomAnchor, constant: 14),
         emiValueLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)].forEach({$0.isActive = true})
        emiValueLabel.alpha = 0
        
        duratinLabel = UILabel()
        self.addSubview(duratinLabel)
        duratinLabel.text = "duration"
        duratinLabel.textColor = .white
        duratinLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        duratinLabel.translatesAutoresizingMaskIntoConstraints = false
        [duratinLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
         duratinLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 20)].forEach({$0.isActive = true})
        duratinLabel.alpha = 0
        
        durationValuelabel = UILabel()
        self.addSubview(durationValuelabel)
        durationValuelabel.text = ""
        durationValuelabel.textColor = .white
        durationValuelabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        durationValuelabel.translatesAutoresizingMaskIntoConstraints = false
        [durationValuelabel.topAnchor.constraint(equalTo: emiLabel.bottomAnchor, constant: 14),
         durationValuelabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 20)].forEach({$0.isActive = true})
        durationValuelabel.alpha = 0
        
        layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 240, height: 200)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        [collectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
         collectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         collectionView.heightAnchor.constraint(equalToConstant: 200),
         collectionView.topAnchor.constraint(equalTo: emiLabel.bottomAnchor, constant: 100)].forEach({$0.isActive = true})
        collectionView.backgroundColor = .clear
        collectionView.register(EmiDistributionCell.self, forCellWithReuseIdentifier: "SomeIdentifier")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clipsToBounds = false
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        
        createPlanBaseView = BaseView.init(with: UIColor(red: 0.09, green: 0.13, blue: 0.17, alpha: 1.00), circular: false, shadow: false, borderColor: AppTheme.baseViewButtonBorderColor, borderThickness: 3)
        self.addSubview(createPlanBaseView)
        createPlanBaseView.translatesAutoresizingMaskIntoConstraints = false
        [createPlanBaseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
         createPlanBaseView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20)].forEach({$0.isActive = true})
        
        let createYourOwnPlanLabel = UILabel()
        self.addSubview(createYourOwnPlanLabel)
        createYourOwnPlanLabel.translatesAutoresizingMaskIntoConstraints = false
        [createYourOwnPlanLabel.leftAnchor.constraint(equalTo: createPlanBaseView.leftAnchor, constant: 20),
         createYourOwnPlanLabel.rightAnchor.constraint(equalTo: createPlanBaseView.rightAnchor, constant: -20),
         createYourOwnPlanLabel.topAnchor.constraint(equalTo: createPlanBaseView.topAnchor, constant: 10),
         createYourOwnPlanLabel.bottomAnchor.constraint(equalTo: createPlanBaseView.bottomAnchor, constant: -10)].forEach({$0.isActive = true})
        createYourOwnPlanLabel.text = "Create your own plan"
        createYourOwnPlanLabel.textColor = AppTheme.baseViewButtonBorderColor
        createYourOwnPlanLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
    }
}
