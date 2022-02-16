//
//  RegisterModel.swift
//  TexBrother_MVVM_Study
//
//  Created by 노한솔 on 2022/02/01.
//

import Foundation

// MARK: - RegisterModel

struct RegisterModel {
    let email: String
    let passWord: String
    let nickName: String
    let privacy: Bool
    let promotion: Bool
}

// TODO - Regex

enum ValidationRegex: String {
    case email = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
    case password = "(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
    case nickname = "^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\\*]{2,}+$"
}

extension String {
    func validate(with regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@" , regex.trimmingCharacters(in: .whitespaces)).evaluate(with: self)
    }
    
    func validate(with regex: ValidationRegex) -> Bool {
        return validate(with: regex.rawValue)
    }
}
