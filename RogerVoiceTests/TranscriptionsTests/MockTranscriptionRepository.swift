//
//  MockTranscriptionRepository.swift
//  RogerVoiceTests
//
//  Created by Ines BOKRI on 25/11/2024.
//

import Foundation
@testable import RogerVoice

class MockTranscriptionRepository: TranscriptionRepository {
    var shouldReturnError = false
    var mockTranscriptions: [Transcription] = []
    
    override func fetchTranscriptions(completion: @escaping (Result<[Transcription], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 500, userInfo: nil)))
        } else {
            completion(.success(mockTranscriptions))
        }
    }
}
