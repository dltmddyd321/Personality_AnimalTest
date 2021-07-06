//
//  QuestionData.swift
//  What_Animal_are_you
//
//  Created by 이승용 on 2021/07/06.
//

import Foundation

struct Question {
    var text:String
    var type:ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, mutiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character { //enum에서 직접 변수 선언이 가능
    case dog = "🐶", cat = "🐱", rabbit = "🐰", koala = "🐨"
    
    var definition : String {
        switch self {
        case .dog :
            return "It's your result!"
        case .cat :
            return "It's your result!"
        case .rabbit :
            return "It's your result!"
        case .koala :
            return "It's your result!"
        }
    }
}
