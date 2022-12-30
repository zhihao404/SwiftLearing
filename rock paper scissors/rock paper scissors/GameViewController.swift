//
//  GameViewController.swift
//  rock paper scissors
//
//  Created by Zhihao Miao on 2022/12/30.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController{
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func tapRockButton(_ sender: Any) {
        play(player: "rock:")
    }
    @IBAction func tapScissorsButton(_ sender: Any) {
        play(player: "scissors:")
    }
    @IBAction func tapPaperButton(_ sender: Any) {
        play(player: "paper:")
    }
    func play(player: String) {
        let opponent = ["rock:", "scissors:", "paper:"].randomElement()!
        if player == opponent {
            resultLabel.text = "引き分け"
        } else if (player == "rock:" && opponent == "scissors:") || (player == "scissors:" && opponent == "paper:") || (player == "paper:" && opponent == "rock:") {
            resultLabel.text = "勝ち!"
        } else {
            resultLabel.text = "負け"
        }
    }
}
