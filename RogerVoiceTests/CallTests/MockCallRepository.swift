//
//  CallRepositoryTests.swift
//  RogerVoiceTests
//
//  Created by Ines BOKRI on 25/11/2024.
//

import Foundation
@testable import RogerVoice

class MockCallRepository: CallRepositoryProtocol {
    var shouldReturnError = false
    var mockCalls: [Call] = []

    func fetchCalls(completion: @escaping (Result<[Call], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 500, userInfo: nil)))
        } else {
            completion(.success(mockCalls))
        }
    }
}
