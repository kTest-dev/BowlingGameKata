//
//  ViewController.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 11/24/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var rollScoreLabel: UILabel!
    @IBOutlet weak var framesCollectionView: UICollectionView!
    
    var currentGame:BowlingGame?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        registerCells()
        setFeedbackMessage()
        setGameButton()
    }
    
    @IBAction func playBtnClicked(_ sender: Any) {
        if currentGame == nil {
            createNewGame()
        }else if currentGame!.isFinished() {
            calculateScore()
        }else{
            playNewRoll()
        }
    }
    
    private func createNewGame() {
        currentGame = BowlingGame()
        playNewRoll()
    }
    private func playNewRoll(){
        var generated = generateRandom(lower: 0, heigher: 10)
        if let lastFrame = currentGame?.allFrames().last, !lastFrame.isCompleted() {
            let neededScore = lastFrame.getNeededScore()
            generated = generateRandom(lower: 0, heigher: neededScore)
            
        }
        currentGame?.play(pins: generated)
        rollScoreLabel.text = "\(generated)"
        setFeedbackMessage()
        framesCollectionView.reloadData()
        if let count = currentGame?.allFrames().count {
            framesCollectionView.scrollToItem(at: IndexPath(item:  count-1, section: 0), at: .left, animated: true)
        }
        setGameButton()
    }
    private func calculateScore(){
        let alert = UIAlertController(title: "alert_title".localize(), message: String(format: "alert_message".localize(),currentGame?.getScore() ?? 0), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "new_game_btn_alert".localize(), style: .default, handler: { _ in
            self.createNewGame()
        }))
        alert.addAction(UIAlertAction(title: "cance_btn_alert".localize(), style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    private func setGameButton() {
        if currentGame == nil {
            gameButton.backgroundColor = UIColor(named: "blueColor")
            gameButton.setTitle("start_new_game_btn".localize(), for: .normal)
        }else if currentGame!.isFinished() {
            
            gameButton.backgroundColor = UIColor(named: "pinkColor")
            gameButton.setTitle("calculate_score_btn".localize(), for: .normal)
        }else{
            gameButton.backgroundColor = UIColor(named: "greenColor")
            gameButton.setTitle("roll_btn".localize(), for: .normal)
        }
    }
    
    private func setFeedbackMessage() {
        if currentGame?.isNewGame() ??  true {
            feedbackLabel.text = "start_game_feedback_message".localize()
            return
        }
        if let currentFrame = currentGame?.allFrames().last {
            if  currentFrame.hasStrike() {
                feedbackLabel.text = "strike_feedback_message".localize()
                return
            }
            if  currentFrame.hasSpare() {
                feedbackLabel.text = "spare_feedback_message".localize()
                return
            }
            if !currentFrame.isCompleted(){
                let neededScore = currentFrame.getNeededScore()
                if neededScore == 10  {
                    feedbackLabel.text = "zero_feedback_message".localize()
                }else{
                    feedbackLabel.text = String(format:"next_roll_feedback_message".localize(),neededScore)
                }
                return
            }else {
                if currentFrame.getSecondRoll()?.getKnockedPins() == 0{
                    feedbackLabel.text = "zero_feedback_message".localize()
                }else{
                    feedbackLabel.text = "next_frame_feedback_message".localize()
                }
            }
        }
    }
    private func generateRandom(lower:Int, heigher:Int) -> Int{
        return Int.random(in: lower...heigher)
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
        return currentGame?.allFrames().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let frameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameFrameCollectionViewCell", for: indexPath) as? GameFrameCollectionViewCell {
            frameCell.index = indexPath
            frameCell.item = currentGame?.allFrames()[indexPath.item]
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


extension String{
    
    func localize() -> String{
        return NSLocalizedString(self,comment: "")
    }
}
