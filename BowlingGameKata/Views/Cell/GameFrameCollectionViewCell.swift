//
//  GameFrameCollectionViewCell.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 11/25/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import UIKit

class GameFrameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstRollView: UIView!
    @IBOutlet weak var secondRollView: UIView!
    @IBOutlet weak var firstRollLabel: UILabel!
    @IBOutlet weak var secondRollLabel: UILabel!
    @IBOutlet weak var frameIndexLabel: UILabel!
    
    var item:GameFrame?{
        didSet{
            if let firstRoll = item?.getFirstRoll(){
                firstRollLabel.text = "\(firstRoll.getKnockedPins())"
            }
            if  let secondRoll = item?.getSecondRoll() {
                secondRollLabel.text = "\(secondRoll.getKnockedPins())"
            }
            
            setColor()
        }
    }
    var index:IndexPath?{
        didSet{
            if let item = index?.item {
                frameIndexLabel.text = "Frame №\(item+1)"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 5;
        contentView.layer.masksToBounds = true;
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named:"lightGrayColor")?.cgColor
        
        firstRollView.layer.cornerRadius = 5
        secondRollView.layer.cornerRadius = 5
        
        clearViews()
    }
    func clearViews() {
        firstRollLabel.text = ""
        secondRollLabel.text = ""
        frameIndexLabel.text = ""

        firstRollView.backgroundColor = UIColor(named:"lightGrayColor")
        secondRollView.backgroundColor = UIColor(named:"lightGrayColor")
    }
    override func prepareForReuse() {
        clearViews()
    }
    func setColor() {
        guard let frame = item else{
            firstRollView.backgroundColor = UIColor(named:"lightGrayColor")
            secondRollView.backgroundColor = UIColor(named:"lightGrayColor")
            return
        }
        if frame.getFirstRoll()?.getKnockedPins() != 0{
            firstRollView.backgroundColor = UIColor(named: "blueColor")
        }else{
            firstRollView.backgroundColor = UIColor(named: "pinkColor")
        }
        if frame.getSecondRoll()?.getKnockedPins() != 0{
            secondRollView.backgroundColor = UIColor(named: "blueColor")
        }else{
            secondRollView.backgroundColor = UIColor(named: "pinkColor")
        }
        
        if  frame.hasStrike() {
            firstRollView.backgroundColor = UIColor(named: "greenColor")
            secondRollView.backgroundColor = UIColor(named:"lightGrayColor")
            return
        }
        if  frame.hasSpare() {
            secondRollView.backgroundColor = UIColor(named: "greenColor")
            return
        }
    }
}

