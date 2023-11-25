//
//  BaseResponse.swift
//  WBDN
//
//  Created by Mason Kim on 11/26/23.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T?
}
