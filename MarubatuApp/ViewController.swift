//
//  ViewController.swift
//  MarubatuApp
//
//  Created by 待寺翼 on 2023/09/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    var currentQuestionNum = 0
    
    let questions: [[String: Any]] = [
        [
            "question": "iphoneアプリを開発する統合環境はZcode",
            "answer": false
        ],
        ["question":"Xcode画面の右側にはユーティリティーズがある",
         "answer":true
        ],
        [
            "question":"UILabelは文字列を表示する際にる利用する",
            "answer":true
        ]
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    // Do any additional setup after loading the view.
    
    func showQuestion() {
        let question = questions[currentQuestionNum]
        
        if let que = question["question"] as? String {
            questionLabel.text = que
        }
    }
    
    func checkAnswer(yourAnswer: Bool){
        let question = questions[currentQuestionNum]
        
        if let  ans = question["answer"]as? Bool {
            if yourAnswer == ans{
                currentQuestionNum += 1
                shoeAlert(messege: "正解！!")
            }else{
                shoeAlert(messege: "不正解")
            }
        }
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        showQuestion()
    }
    func shoeAlert(messege: String){
        let alert = UIAlertController(title: "解答", message: messege, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel)
        alert.addAction(close)
        present(alert,animated:true, completion:nil)
        
    }
        
        
        @IBAction func tappedNoButton(_ sender: UIButton) {
            checkAnswer(yourAnswer: false)
        }
        
        @IBAction func tappedYesButton(_ sender: UIButton) {
            checkAnswer(yourAnswer: true)
        }
    }
    
    

