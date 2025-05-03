//
//  ViewController.swift
//  HW9_MultipleChoice
//
//  Created by Kate Yeh on 2025/4/15.
//

import UIKit

class ViewController: UIViewController {
    
    //題號Label
    @IBOutlet weak var questionNumberLabel: UILabel!
    //題目Label
    @IBOutlet weak var questionsLabel: UILabel!
    //答題進度Slider
    @IBOutlet weak var questionNumberSlider: UISlider!
    //選項按鈕們
    @IBOutlet var optionButtons: [UIButton]!
    //下一題按鈕
    @IBOutlet weak var nextButton: UIButton!
    
    
    //題目資料陣列
    var questions : [QuestionList] = []
    var currentIndex = 0
    var score = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //設定題庫
        settingQuestions()
        //題目隨機排序
        questions.shuffle()
        
        
        //設定題號字體樣式、大小
        questionNumberLabel.font = UIFont(name: "Papyrus", size: 25)
        //設定題目字體樣式、大小
        questionsLabel.font = UIFont(name: "Papyrus", size: 20)
        //題目可以多行
        questionsLabel.numberOfLines = 0
        //題目自動換行
        questionsLabel.lineBreakMode = .byWordWrapping
        //題目字太長就自動縮小字
        questionsLabel.adjustsFontSizeToFitWidth = true
        //字體最小縮到原來的70%
        questionsLabel.minimumScaleFactor = 0.7
        
        
        //設定Slider圖案
        questionNumberSlider.setThumbImage(UIImage(named: "sliderImage.png"), for: UIControl.State.normal)
        //設定Slider顏色
        questionNumberSlider.tintColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        //設定Slider最大值
        questionNumberSlider.maximumValue = Float(questions.count)
        //設定Slider最小值
        questionNumberSlider.minimumValue = 1
        //Slider從1開始(第一題)
        questionNumberSlider.value = 1
        
        
        //更新畫面(顯示第一題)
        updateUI()
        
    }
    
    //設定題庫
    func settingQuestions(){
        questions = [
            QuestionList(
                questions: "Swift 中 `let` 關鍵字的用途是什麼？",
                correctAnswerIndex: 2,
                options: ["宣告可變變數", "宣告函式", "宣告常數", "宣告類別"],
                explanation: "`let` 是用來宣告常數，也就是一旦賦值後不能再改變。"
            ),
            QuestionList(
                questions: "下列哪一種語法可以正確定義一個 Optional Int？",
                correctAnswerIndex: 0,
                options: ["var number: Int?", "var number: optional Int", "optional Int number", "var number = Int optional"],
                explanation: "`Int?` 表示這是一個 optional 型別的 Int。"
            ),
            QuestionList(
                questions: "`guard` 語句通常搭配哪種用途？",
                correctAnswerIndex: 2,
                options: ["執行 for 迴圈", "處理異步程式", "條件提早離開", "宣告 enum"],
                explanation: "`guard` 常用於提前離開函式，以確保條件成立。"
            ),
            QuestionList(
                questions: "下列哪一個可以用來處理 Swift 的錯誤？",
                correctAnswerIndex: 0,
                options: ["try/catch", "if/else", "do/while", "switch/case"],
                explanation: "Swift 使用 `do { try ... } catch {}` 結構來處理錯誤。"
            ),
            QuestionList(
                questions: "Swift 中，哪個關鍵字用來宣告一個 protocol？",
                correctAnswerIndex: 2,
                options: ["interface", "contract", "protocol", "abstract"],
                explanation: "Swift 使用 `protocol` 來定義協議。"
            ),
            QuestionList(
                questions: "下列哪一個是 UIViewController 的生命週期方法？",
                correctAnswerIndex: 0,
                options: ["viewDidLoad()", "didReceiveMemoryWarning()", "viewSetLayout()", "loadUI()"],
                explanation: "`viewDidLoad()` 是畫面載入後最先呼叫的生命週期方法之一。"
            ),
            QuestionList(
                questions: "使用 UIScrollView 時，為了支援多頁水平滾動，通常會設定：",
                correctAnswerIndex: 0,
                options: ["pagingEnabled = true", "isSelectable = true", "scrollingMode = .horizontal", "scrollEnabled = false"],
                explanation: "`isPagingEnabled = true` 讓你每次滑動一整頁。"
            ),
            QuestionList(
                questions: "若要在畫面中實現點擊按鈕跳轉到下一個畫面，應該使用？",
                correctAnswerIndex: 1,
                options: ["Notification", "segue", "enum", "delegate"],
                explanation: "Storyboard 中使用 segue 來做畫面跳轉。"
            ),
            QuestionList(
                questions: "哪一個元件用來呈現一個清單樣式的資料？",
                correctAnswerIndex: 1,
                options: ["UISlider", "UITableView", "UIButton", "UIImageView"],
                explanation: "`UITableView` 是用來顯示清單資料的常見元件。"
            ),
            QuestionList(
                questions: "想讓使用者在兩種以上的選項間切換，應該使用哪個元件？",
                correctAnswerIndex: 1,
                options: ["UITextView", "UISegmentedControl", "UISwitch", "UILabel"],
                explanation: "`UISegmentedControl` 適合讓使用者做單選切換。"
            ),
            QuestionList(
                questions: "Swift 使用哪個技術來管理記憶體？",
                correctAnswerIndex: 1,
                options: ["Manual GC", "ARC", "AOT", "MRC"],
                explanation: "Swift 使用 ARC（自動引用計數）管理記憶體。"
            ),
            QuestionList(
                questions: "避免 retain cycle 的關鍵字是？",
                correctAnswerIndex: 2,
                options: ["lazy", "strong", "unowned", "copy"],
                explanation: "`unowned`（或 `weak`）可避免閉包或物件間的強參考循環。"
            ),
            QuestionList(
                questions: "哪一個情境容易造成 retain cycle？",
                correctAnswerIndex: 2,
                options: ["Struct 互相持有", "Delegate 使用 weak", "ViewController 中 Timer 強參考 self", "使用 enum 作為模型"],
                explanation: "Timer 強參考 self 且未設為 weak，會造成 memory leak。"
            ),
            QuestionList(
                questions: "使用 weak 時，變數一定是？",
                correctAnswerIndex: 1,
                options: ["non-optional", "optional", "struct", "immutable"],
                explanation: "weak 屬性在目標被釋放時自動設為 nil，所以必須是 optional。"
            ),
            QuestionList(
                questions: "ARC 會在什麼時候釋放記憶體？",
                correctAnswerIndex: 1,
                options: ["當 CPU 忙碌時", "當物件參考計數歸零時", "每秒定時自動清除", "編譯時即釋放"],
                explanation: "ARC 會在物件參考數為 0 時自動釋放記憶體。"
            ),
            QuestionList(
                questions: "Xcode 中用來檢查 UI 階層的工具是？",
                correctAnswerIndex: 2,
                options: ["Interface Inspector", "Debug Navigator", "View Debugger", "Symbol Browser"],
                explanation: "`View Debugger` 可 3D 分析 UI 元件的層級。"
            ),
            QuestionList(
                questions: "若要即時觀察變數內容，可以使用？",
                correctAnswerIndex: 1,
                options: ["Console print", "Breakpoint + po", "Source Editor", "Interface Builder"],
                explanation: "在中斷點輸入 `po 變數名` 可印出變數的實際內容。"
            ),
            QuestionList(
                questions: "想追蹤某變數值是否被改動，可使用哪種 breakpoint？",
                correctAnswerIndex: 2,
                options: ["Symbolic Breakpoint", "Exception Breakpoint", "Watchpoint", "Condition Breakpoint"],
                explanation: "Watchpoint 可追蹤特定變數何時被讀寫。"
            ),
            QuestionList(
                questions: "若專案無法執行，但不顯示錯誤，應先嘗試？",
                correctAnswerIndex: 0,
                options: ["清除 Derived Data", "重開 Xcode", "修改 scheme", "關閉 auto layout"],
                explanation: "Derived Data 可能造成編譯問題，清除可解決奇怪 bug。"
            ),
            QuestionList(
                questions: "遇到 unexpectedly found nil while unwrapping 錯誤，表示？",
                correctAnswerIndex: 1,
                options: ["型別不符合", "強制拆包 optional 卻為 nil", "記憶體不足", "無法解析 JSON"],
                explanation: "強制拆包 (`!`) 時若為 nil，會 crash 並拋出此錯誤。"
            ),
            QuestionList(
                questions: "在 MVC 中，View 應該？",
                correctAnswerIndex: 2,
                options: ["管理所有邏輯", "處理網路請求", "呈現 UI 元件", "儲存資料模型"],
                explanation: "View 負責顯示畫面，不應包含商業邏輯。"
            ),
            QuestionList(
                questions: "Model 的職責包含？",
                correctAnswerIndex: 1,
                options: ["管理介面佈局", "負責邏輯與資料", "回應按鈕事件", "設定 tableView delegate"],
                explanation: "Model 層負責與資料相關的操作與邏輯。"
            ),
            QuestionList(
                questions: "控制器（Controller）應該做什麼？",
                correctAnswerIndex: 2,
                options: ["顯示圖片", "管理資料存取", "協調 View 與 Model", "管理 storyboard"],
                explanation: "Controller 負責將 Model 的資料顯示在 View 上。"
            ),
            QuestionList(
                questions: "為了減少 Controller 負擔，可使用？",
                correctAnswerIndex: 1,
                options: ["Helper", "MVVM 架構", "Singleton", "Thread"],
                explanation: "MVVM 把邏輯拆到 ViewModel，Controller 更乾淨。"
            ),
            QuestionList(
                questions: "在 MVC 中，哪個組件應該處理用戶輸入事件？",
                correctAnswerIndex: 1,
                options: ["Model", "Controller", "View", "AppDelegate"],
                explanation: "使用者互動邏輯應在 Controller 中處理。"
            ),
            QuestionList(
                questions: "將兩個 View 疊加，應使用哪個 UIView 方法？",
                correctAnswerIndex: 0,
                options: ["addSubview()", "insertView()", "appendChild()", "mergeView()"],
                explanation: "`addSubview()` 可將 View 加入另一 View 上方。"
            ),
            QuestionList(
                questions: "UIView 做淡入動畫，應使用？",
                correctAnswerIndex: 0,
                options: ["UIView.animate", "addSubview", "DispatchQueue.main", "removeFromSuperview"],
                explanation: "`UIView.animate(withDuration:)` 可建立動畫效果。"
            ),
            QuestionList(
                questions: "從 JSON 解析成模型，Swift 中推薦使用？",
                correctAnswerIndex: 1,
                options: ["NSCoding", "Codable", "JSONKit", "StringInterpolation"],
                explanation: "`Codable` 是 Swift 中解析與序列化 JSON 的首選。"
            ),
            QuestionList(
                questions: "播放音效應使用哪個 framework？",
                correctAnswerIndex: 2,
                options: ["UIKit", "CoreMotion", "AVFoundation", "Photos"],
                explanation: "`AVFoundation` 是 Apple 播放音訊／影片的框架。"
            ),
            QuestionList(
                questions: "實作購物車的資料結構建議使用？",
                correctAnswerIndex: 1,
                options: ["Set", "Dictionary", "String", "Double"],
                explanation: "Dictionary 最適合搭配商品名稱與數量的對應。"
            )
        ]
    }
    
    //設定按鈕樣式
    func setupButtonStyle(_ button: UIButton){
        //先清掉按鈕預設樣式configuration，避免被覆蓋
        button.configuration = nil
        nextButton.configuration = nil
        //文字垂直置中
        button.contentVerticalAlignment = .center
        //文字水平置中
        button.contentHorizontalAlignment = .center
        //字太多時自動縮小字體以符合button寬度
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        //最小縮一半50%
        button.titleLabel?.minimumScaleFactor = 0.5
        
        
        //button外觀設計
        //圓角弧度
        button.layer.cornerRadius = 10
        //外框線條寬度
        button.layer.borderWidth = 2
        //外框線條顏色
        button.layer.borderColor = UIColor(red: 159/255, green: 157/255, blue: 151/255, alpha: 1).cgColor
        //按鈕背景顏色
        button.backgroundColor = UIColor(red: 242/255, green: 239/255, blue: 229/255, alpha: 1)
        //按鈕文字顏色
        button.setTitleColor(.black, for: .normal)
        //按鈕文字字體大小
        button.titleLabel?.font = UIFont(name: "Papyrus", size: 20)
    }
    
    
    //更新畫面
    func updateUI(){
        //更新題號label
        questionNumberLabel.text = "第 \(currentIndex + 1) 題"
        //更新Slider進度
        questionNumberSlider.value = Float(currentIndex + 1)
        
        
        //顯示當前題目與選項
        let question = questions[currentIndex]
        questionsLabel.text = question.questions
        
        for (index, button) in optionButtons.enumerated() {
            //先設定選項外觀
            setupButtonStyle(button)
            //再設定選項文字
            button.setTitle(question.options[index], for: .normal)
            button.isEnabled = true
        }
        
        
        //設定Next按鈕外觀
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "Impact", size: 30)
        nextButton.layer.cornerRadius = 15
        nextButton.setTitle("Next", for: .normal)
        nextButton.backgroundColor = UIColor(red: 254/255, green: 252/255, blue: 247/255, alpha: 1)
        nextButton.setTitleColor(.black, for: .normal)
        
        //Next按鈕加陰影(增加立體感)
        //設定按鈕陰影顏色
        nextButton.layer.shadowColor = UIColor.black.cgColor
        //設定陰影透明度(0~1)
        nextButton.layer.shadowOpacity = 0.25
        //設定陰影的偏移位置
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        //設定陰影的模糊程度
        nextButton.layer.shadowRadius = 5
        nextButton.isHidden = true
    }
    
    
    
    //點了選項按鈕後(判斷是否答題正確)
    @IBAction func OptionSelected(_ sender: UIButton){
        guard let selectedIndex = optionButtons.firstIndex(of: sender) else { return }
        
        let correctIndex = questions[currentIndex].correctAnswerIndex
        
        for (i, button) in optionButtons.enumerated() {
            button.isEnabled = false
            if i == correctIndex {
                //設定答對綠色
                button.backgroundColor = UIColor(red: 110/255, green: 190/255, blue: 122/255, alpha: 1)
                //選項邊框顏色
                button.layer.borderColor = UIColor(red: 159/255, green: 157/255, blue: 151/255, alpha: 1).cgColor
            } else if i == selectedIndex {
                //設定答錯紅色
                button.backgroundColor = UIColor(red: 199/255, green: 127/255, blue: 129/255, alpha: 1)
                //選項邊框顏色
                button.layer.borderColor = UIColor(red: 159/255, green: 157/255, blue: 151/255, alpha: 1).cgColor
            }
        }
        
        //答對累加分數
        if selectedIndex == correctIndex {
            score += 1
        }
        nextButton.isHidden = false
    }

    
    //進到下一題
    @IBAction func nextButton(_ sender: Any) {
        //如果目前是最後一題，就跳到結果頁面
        if currentIndex == questions.count - 1 {
            showFinalScore()
        //反之如果還有題目，題號+1，然後更新畫面顯示新題目
        }else {
            currentIndex += 1
            updateUI()
        }
        
        //如果是最後一題，按鈕文字改成Score，點擊後顯示成績
        if currentIndex == questions.count - 1 {
            nextButton.setTitle("Score", for: .normal)
        //反之如果還沒最後一題，維持按鈕文字Next
        }else{
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    
    //顯示總成績頁面(跳轉ScoreViewController)
    func showFinalScore() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //連結ScoreViewController
        if let resultVC = storyboard.instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController {
            resultVC.finalScore = score
            resultVC.totalQuestions = questions.count
            //指定自己作為代理人，讓Scorepage可以通知"Retry"
            resultVC.delegate = self
            self.present(resultVC, animated: true, completion: nil)
        }
    }
    
}

//延伸ViewController類別，實作RetryDelegate協定
extension ViewController: RetryDelegate {
    //實作協定：當ScoreViewController按下Retry時呼叫function
    func didTapRetry() {
        
        currentIndex = 0
        score = 0
        questions.shuffle()
        questionNumberSlider.value = 1
        updateUI()
    }
}

