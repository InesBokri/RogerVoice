//
//  CallViewModel.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 21/11/2024.
//

import Foundation

class CallViewModel {
    
    // MARK: - Properties
    private let callRepository: CallRepositoryProtocol
    private let transcriptionRepository: TranscriptionRepository
    var calls = [Call]()
    var transcriptions = [Transcription]()
    var onError: ((String) -> Void)?
    var onDataUpdated: (() -> Void)?
    var isCallsEmpty: Bool {
        return calls.isEmpty
    }
    
    init(callRepository: CallRepositoryProtocol = CallRepository(), transcriptionRepository: TranscriptionRepository = TranscriptionRepository()) {
        self.callRepository = callRepository
        self.transcriptionRepository = transcriptionRepository
    }
    
    // MARK: - Functions
    func loadCallsAndTranscriptions() {
        callRepository.fetchCalls { [weak self] result in
            switch result {
            case .success(let calls):
                self?.calls = calls
                self?.loadTranscriptions()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
    
    func loadTranscriptions() {
        transcriptionRepository.fetchTranscriptions { [weak self] result in
            switch result {
            case .success(let transcriptions):
                self?.transcriptions = transcriptions
                self?.onDataUpdated?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }

    func hasTranscriptions(for callUUID: String) -> Bool {
        return transcriptions.contains { $0.callUuid == callUUID }
    }
    
    func transcriptions(for callUUID: String) -> [Transcription] {
        return transcriptions.filter { $0.callUuid == callUUID }
    }
}
