//
//  TranscriptionRepository.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 23/11/2024.
//

import Foundation

protocol TranscriptionRepositoryProtocol {
    func fetchTranscriptions(completion: @escaping (Result<[Transcription], Error>) -> Void)
}

class TranscriptionRepository: TranscriptionRepositoryProtocol {
    func fetchTranscriptions(completion: @escaping (Result<[Transcription], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = Bundle.main.url(forResource: "transcriptions", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "FileNotFound", code: 404, userInfo: nil)))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(TranscriptionsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.transcription))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
