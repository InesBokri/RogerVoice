//
//  TranscriptionsViewModel.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 18/11/2024.
//

import SwiftUI

class TranscriptionsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var transcriptions: [Transcription]
    let phoneNumber: String
    let callDate: String

    init(transcriptions: [Transcription], phoneNumber: String, callDate: String) {
        self.transcriptions = transcriptions
        self.phoneNumber = phoneNumber
        self.callDate = callDate
    }

    func formattedCallDate() -> String {
        return callDate.formattedDate() ?? ""
    }
}
