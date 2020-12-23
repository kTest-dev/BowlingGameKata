//
//  ViewController.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import UIKit
import Lottie
class ViewController: UIViewController{
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var rollScoreLabel: UILabel!
    @IBOutlet weak var framesCollectionView: UICollectionView!

    
    let animationView = AnimationView()
    
    var viewModel:BowlingGameViewModel? = BowlingGameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAnimationView()
        setupViews()
        registerCells()
        bindViewModel()
    }
    func bindViewModel() {
        guard  let viewModel = viewModel else {
            return
        }
        viewModel.state.bindAndCall { (state) in
            self.gameButton.backgroundColor = state.getButtonColor()
            self.gameButton.setTitle(state.getButtonText(), for: .normal)
        }
        viewModel.finalScore.bind { (score) in
            self.displayAlertWithScore(score: score)
        }
        viewModel.randomValue.bind { (generated) in
            self.rollScoreLabel.text = "\(generated)"
        }
        viewModel.feedBackMessage.bindAndCall { (message) in
            self.feedbackLabel.text = message
        }
        viewModel.frameNumber.bind { (position) in
            self.framesCollectionView.reloadData()
            self.scrollToFrame(index: position-1)
        }
        viewModel.animation.bindAndCall { (animation) in
            self.playAnimationWithName(name: animation)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationView.play()
    }
    
    @IBAction func playBtnClicked(_ sender: Any) {
        viewModel?.didClickOnPlayBtn()
    }
    
    
    fileprivate func setAnimationView() {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.alpha = 1
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1
        
        view.addSubview(animationView)
        animationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        animationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        animationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        view.sendSubviewToBack(animationView)
    }
    
    fileprivate func playAnimationWithName(name:String) {
        let animation = Animation.named(name)
        animationView.isHidden = false
        animationView.animation = animation
        animationView.play { (comleted) in
            self.animationView.isHidden = true
        }
    }


    private func scrollToFrame(index:Int){
        framesCollectionView.reloadData()
        let indexPath = IndexPath(item:  index, section: 0)
        framesCollectionView.scrollToItem(at:indexPath , at: .left, animated: true)
    }
    private func displayAlertWithScore(score:Int){
        let alertMessage = String(format: "alert_message".localize(),score)
        let alertTitle = "alert_title".localize()
        let alert = UIAlertController(title:alertTitle , message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "new_game_btn_alert".localize(), style: .default, handler: { _ in
            self.viewModel?.didClickOnNewGame()
        }))
        alert.addAction(UIAlertAction(title: "cance_btn_alert".localize(), style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    private func setupViews(){
        gameButton.layer.cornerRadius = 8
        gameButton.clipsToBounds = true
        feedbackLabel.text = ""
        rollScoreLabel.text = ""
        framesCollectionView.delegate = self
        framesCollectionView.dataSource = self
        framesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
    
    private func registerCells(){
        framesCollectionView.register(UINib(nibName: "GameFrameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GameFrameCollectionViewCell")
    }
    
}


extension  ViewController: UICollectionViewDelegate,UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.currentGame?.allFrames().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let frameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameFrameCollectionViewCell", for: indexPath) as? GameFrameCollectionViewCell {
            frameCell.index = indexPath
            frameCell.item = viewModel?.currentGame?.allFrames()[indexPath.item]
            return frameCell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
