//
//  ResultViewController.swift
//  What_Animal_are_you
//
//  Created by 이승용 on 2021/07/05.
//

import UIKit

class ResultViewController: UIViewController {

    var responses: [Answer] = []
    
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        calPersonality()
    }
    
    func calPersonality() {
        var frequencyOfAnswer : [AnimalType: Int] = [:]
        //딕셔러니 초기화
        
        let responseTypes = responses.map{$0.type}
        //배열 값 하나하나를 $0 자리에 넣어 코드 실행
        
        for response in responseTypes {
            frequencyOfAnswer[response] = (frequencyOfAnswer[response] ?? 0) + 1
        }
        
        let frequentAnswerSorted = frequencyOfAnswer.sorted(by: {
            (pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        //인자 값 두 개를 비교한 뒤 정렬하는 closure 구문
        
        let mostCommonAnswer = frequentAnswerSorted.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        //가장 선택 빈도수가 높았던 예상 결과 값 반환
        
        resultDefinitionLabel.text = mostCommonAnswer.definition
        //가장 선택 빈도수가 높았던 예상 결과에 대한 설명 반환
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
