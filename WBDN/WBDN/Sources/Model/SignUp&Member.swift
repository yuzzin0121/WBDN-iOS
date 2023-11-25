//
//  SignUp&Member.swift
//  WBDN
//
//  Created by Mason Kim on 11/26/23.
//

import Foundation

struct SignUpDto: Codable {
    let loginId: String
    let password: String
    let nickname: String
}

struct SignUpResponse: Codable {
    let memberId: Int
}

struct SignInDto: Codable {
    let loginId: String
    let password: String
}

struct SignInResponse: Codable {
    let accessKey: String
}

struct Member: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let loginId: String
    let password: String
    let nickname: String
}
