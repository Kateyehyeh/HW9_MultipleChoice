//
//  ScoreViewController.swift
//  HW9_MultipleChoice
//
//  Created by Kate Yeh on 2025/4/27.
//

import UIKit

protocol RetryDelegate: AnyObject {
    func didTapRetry()
}

class ScoreViewController: UIViewController {
    
    weak var delegate: RetryDelegate?

    var finalScore: Int = 0
    var totalQuestions: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var RetryButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //先清掉按鈕預設樣式configuration，避免被覆蓋
        RetryButton.configuration = nil
        
        //設定Retry按鈕外觀
        RetryButton.setTitleColor(.black, for: .normal)
        RetryButton.titleLabel?.font = UIFont(name: "Impact", size: 30)
        RetryButton.layer.cornerRadius = 15
        RetryButton.setTitle("Retry", for: .normal)
        RetryButton.backgroundColor = UIColor(red: 254/255, green: 252/255, blue: 247/255, alpha: 1)
        RetryButton.setTitleColor(.black, for: .normal)
        
        //Retry按鈕加陰影(增加立體感)
        //設定按鈕陰影顏色
        RetryButton.layer.shadowColor = UIColor.black.cgColor
        //設定陰影透明度(0~1)
        RetryButton.layer.shadowOpacity = 0.25
        //設定陰影的偏移位置
        RetryButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        //設定陰影的模糊程度
        RetryButton.layer.shadowRadius = 5
        RetryButton.isHidden = false
    }
    
    //每次畫面即將出現前呼叫(比viewDidLoad更適合處理即時更新)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //顯示成績在scorelabel上
        scoreLabel.text = "Final Score：\n\(finalScore) / \(totalQuestions) 🎯"
    }
    
    
    @IBAction func TapRetryButton(_ sender: Any) {
        //呼叫代理人(ViewController)實作的didTapRetry()方法
        delegate?.didTapRetry()
        //關閉ScoreViewController畫面，回到主畫面ViewController
        self.dismiss(animated: true, completion: nil)
    }
    


}
