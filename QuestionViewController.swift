//
//  QuestionViewController.swift
//  MarubatuApp
//
//  Created by 待寺翼 on 2023/09/04.
//

import UIKit
protocol QuestionDelegate {
    func didUpdateQuestions(updatedQuestions: [[String : Any]])
}
class QuestionViewController: UIViewController {
    
    @IBOutlet weak var addQuestionTextField: UITextField!
    var questions: [[String:Any]] = []
    var delegate: QuestionDelegate?
    @IBOutlet weak var marubatsuSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addQuestionTextField.placeholder = "問題文を入力してください"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func questionSetButton(_ sender: Any) {
        
        if  addQuestionTextField.text! != "" {
            var marubatsuAnswer: Bool = false
            
            
            if marubatsuSegment.selectedSegmentIndex == 0 {
                marubatsuAnswer = false
                
            } else {
                
                marubatsuAnswer = true
            }
            let userDefaults = UserDefaults.standard
            questions = []
            
           
            if userDefaults.object(forKey: "questions")  != nil {
                
                questions = userDefaults.object(forKey: "questions") as! [[String: Any]]
            }
            
            questions.append(
                [
                    "question": addQuestionTextField.text!,
                    "answer": marubatsuAnswer
                ])
           
            userDefaults.set(questions, forKey: "questions")
            showAlert(message: "問題が保存されました")
            addQuestionTextField.text = ""
            
        } else {
            showAlert(message: "問題文を入力してください。")
        }
        
        let answer = marubatsuSegment.selectedSegmentIndex == 1
        let newQuestion = [
            "question": addQuestionTextField,
            "answer": answer
        ] as [String : Any]
        questions.append(newQuestion)
        addQuestionTextField.text = ""
        showAlert(message: "問題を保存しました")
        delegate?.didUpdateQuestions(updatedQuestions: questions) // 保存した問題をViewControllerに渡す
    }
    
    
    
    @IBAction func allClearButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "questions")
        userDefaults.set([], forKey: "questions")
        showAlert(message: "問題をすべて削除しました。")
        
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
}
extension QuestionViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */





