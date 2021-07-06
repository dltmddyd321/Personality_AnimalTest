//
//  QuestionViewController.swift
//  What_Animal_are_you
//
//  Created by 이승용 on 2021/07/05.
//

import UIKit

class QuestionViewController: UIViewController {

    var questions: [Question] = [
        Question(text: "Which food do you like the most?", type: .single, answers: [
            Answer(text: "Steak", type: .dog),
            Answer(text: "Fish", type: .cat),
            Answer(text: "Carrot", type: .rabbit),
            Answer(text: "Corn", type: .koala)
        ]),
        Question(text: "Which actvities do you enjoy?", type: .mutiple, answers: [
            Answer(text: "Climbing", type: .koala),
            Answer(text: "Sleeping", type: .cat),
            Answer(text: "Cuddling", type: .rabbit),
            Answer(text: "Eating", type: .dog)
        ]),
        Question(text: "How much do you enjoy car rides?", type: .ranged, answers: [
            Answer(text: "I dislike them", type: .cat),
            Answer(text: "I got a little nervous", type: .rabbit),
            Answer(text: "I barely notice them", type: .koala),
            Answer(text: "I love them", type: .dog)
        ])
    ]
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var mutipleStackView: UIStackView!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet weak var questionProgress: UIProgressView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var rangedLables: [UILabel]!
    
    @IBOutlet var multiLables: [UILabel]!
    
    @IBOutlet var multiSwitch: [UISwitch]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        singleStackView.isHidden = true
        mutipleStackView.isHidden = true
        rangedStackView.isHidden = true
        //초기에는 모두 안보이도록 설정
        
        
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        //0번 문재부터 시작하지 않도록 +1
        
        questionLabel.text = currentQuestion.text
        questionProgress.setProgress(totalProgress, animated: true)
        //문항에 따른 ProgressBar 및 텍스트 반환
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .mutiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    
    //4 종류의 경우가 반복문을 통해 결과를 반환하고 진행되도록 구현
    func updateSingleStack(using answers:[Answer]) {
        singleStackView.isHidden = false
        for i in 0...3 {
            singleButtons[i].setTitle(answers[i].text, for: .normal)
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        mutipleStackView.isHidden = false
        for i in 0...3{
            multiSwitch[i].isOn = false
            multiLables[i].text = answers[i].text
        }
    }
    
    func updateRangedStack(using anwers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLables[0].text = anwers.first?.text
        rangedLables[1].text = anwers.last?.text
    }
    
    
    @IBAction func singleAnswerBtnPressed(_ sender: UIButton) {
        
        let currentAnswer = questions[questionIndex].answers
        
        switch sender {
        case singleButtons[0]:
            answersChosen.append(currentAnswer[0])
        case singleButtons[1]:
            answersChosen.append(currentAnswer[1])
        case singleButtons[2]:
            answersChosen.append(currentAnswer[2])
        case singleButtons[3]:
            answersChosen.append(currentAnswer[3])
        default: break
        }
        
        nextQuestion()
        
    }
    
    @IBAction func multipleBtnAnswer(_ sender: Any) {
        
        let currentAnswers = questions[questionIndex].answers
        if multiSwitch[0].isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch[1].isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch[2].isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch[3].isOn{
            answersChosen.append(currentAnswers[3])
        }
        //스위치가 ON이면 선택 항목에 추가
        
        nextQuestion()
    }
    
    
    
    @IBAction func rangedAnswerBtnPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            //카운트가 인덱스 값보다 크면 다음 문제 호출
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.responses = answersChosen
            //사용자의 선택에 의해 최종 결과 화면으로 이동
        }
    }
    
}
