//
//  SaveCommentRequest.swift
//  WBDN
//
//  Created by Mason Kim on 11/26/23.
//

import Foundation

struct SaveCommentDto: Codable {
    let commentId: Int
    let createdAt: String
}

struct SaveReplyDto: Codable {
    let contents: String
}

struct GetCommentDto: Codable {
    let commentId: Int
    let content: String
    let createdAt: String
}

struct GetReplyDto: Codable {
    let replyId: Int
    let content: String
    let createdAt: String
}

struct GetCommentsDto: Codable {
    let comments: [GetCommentDto]
}

struct GetRepliesDto: Codable {
    let replies: [GetReplyDto]
}

