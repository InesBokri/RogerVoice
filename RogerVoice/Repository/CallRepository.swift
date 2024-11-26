//
//  CallRepository.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 21/11/2024.
//

import Foundation

protocol CallRepositoryProtocol {
    func fetchCalls(completion: @escaping (Result<[Call], Error>) -> Void)
}

class CallRepository: CallRepositoryProtocol {
    func fetchCalls(completion: @escaping (Result<[Call], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let url = Bundle.main.url(forResource: "calls", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "FileError", code: 404, userInfo: nil)))
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(CallResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.call))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
