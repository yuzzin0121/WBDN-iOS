//
//  WoobamAPI.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import Moya
import Foundation

enum WoobamAPI {
    case fetchUser
}

extension WoobamAPI: TargetType {
    var baseURL: URL {
        URL(string: "base_url")!
    }
    
    var path: String {
        switch self {
        case .fetchUser:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUser:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchUser:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
    

}
