//
//  NetworkService.swift
//  WBDN
//
//  Created by Mason Kim on 11/25/23.
//

import Moya
import Foundation

protocol NetworkServiceProtocol: AnyObject {
    associatedtype API: TargetType
    func request<T: Decodable>(_ target: API, type: T.Type) async throws -> T
}

enum NetworkServiceType {
    case server
    case stub
}

/// 각 API에 따른 요청을 처리하는 네트워크 서비스
///
/// 사용 예시
/// ```
///  // 추가 예정
/// ```
final class NetworkService<Target: TargetType>: NetworkServiceProtocol {

    // MARK: - Properties

    private let provider: MoyaProvider<Target>
    private let decoder = JSONDecoder()

    // MARK: - Initialization

    init(type: NetworkServiceType = .server, isLogEnabled: Bool = false) {
        let plugins = isLogEnabled ? [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))] : []

        switch type {
        case .server:
            self.provider = MoyaProvider<Target>(plugins: plugins)
        case .stub:
            /// 서비스의 타입이 stub 일 경우, 1초 후에 sampleData 를 반환하는 provider를 생성
            self.provider = MoyaProvider<Target>(stubClosure: MoyaProvider.delayedStub(1.0), plugins: plugins)
        }
    }

    // MARK: - Public

    // Moya + Concurrency 으로 구현
    func request<T: Decodable>(_ target: Target, type: T.Type) async throws -> T {
        let response = try await provider.request(target)
        let data = try decoder.decode(type, from: response.data)
        return data
    }
}

extension MoyaProvider {
    func request(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case let .success(response):
                    continuation.resume(returning: response)

                case let .failure(error):
                    continuation.resume(throwing: error)
                }

            }
        }
    }
}
