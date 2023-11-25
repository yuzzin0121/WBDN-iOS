//
//  Date+Extension.swift
//  WBDN
//
//  Created by Mason Kim on 11/26/23.
//

import Foundation

extension Date {
    static let dateFormatter = ISO8601DateFormatter().then {
        $0.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    }

    /// 서버랑 통신할 때 이걸로 변환해서 쓰세요!!
    var serverDateString: String {
        Self.dateFormatter.string(from: Date())
    }
}

extension String {
    var serverDate: Date {
        Date.dateFormatter.date(from: self) ?? Date()
    }
}
