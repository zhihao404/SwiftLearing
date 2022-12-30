//
//  ViewController.swift
//  HelloSwift
//
//  Created by Zhihao Miao on 2022/12/16.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func dogButton(_ sender: Any) {
        label.text = "わんわん"
    }
    
    @IBAction func catButton(_ sender: Any) {
        label.text = "にゃあにゃあ"
    }
    
    @IBAction func frogButton(_ sender: Any) {
        label.text = "げろげろ"
    }
}

