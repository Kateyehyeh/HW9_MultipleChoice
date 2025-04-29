//
//  ScoreViewController.swift
//  HW9_MultipleChoice
//
//  Created by Kate Yeh on 2025/4/27.
//

import UIKit

class ScoreViewController: UIViewController {

    var finalScore: Int = 0
    var totalQuestions: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //每次畫面即將出現前呼叫(比viewDidLoad更適合處理即時更新)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //顯示成績在scorelabel上
        scoreLabel.text = "Final Score：\n\(finalScore) / \(totalQuestions) 🎯"
    }


}
