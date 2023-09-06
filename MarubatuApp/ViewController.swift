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
    var questions: [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        questions = []
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "questions") != nil {
            questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
        }
        showQuestion()
    }
    
    // Do any additional setup after loading the view.
    
    func showQuestion() {
        if currentQuestionNum >= questions.count {
            questionLabel.text = "問題がありません"
            return
        }
        let question = questions[currentQuestionNum]
        
        if let que = question["question"] as? String {
            questionLabel.text = que
        }
    }
    
    func checkAnswer(yourAnswer: Bool){
        if questions.isEmpty { return }
        let question = questions[currentQuestionNum]
        
        if let  ans = question["answer"]as? Bool {
            if yourAnswer == ans{
                currentQuestionNum += 1
                showAlert(messege: "正解！!")
            }else{
                showAlert(messege: "不正解")
            }
        }
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        showQuestion()
    }
    func showAlert(messege: String){
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



