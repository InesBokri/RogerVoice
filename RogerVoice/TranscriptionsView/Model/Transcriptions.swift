//
//  Transcriptions.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 18/11/2024.
//

import Foundation

enum TranscriptionDirection: Int, Codable {
    case outgoing = 0
    case incoming = 1
}

struct Transcription: Decodable {
    let uuid: String
    let callUuid: String
    let direction: TranscriptionDirection
    let text: String
}

struct TranscriptionsResponse: Decodable {
    let transcription: [Transcription]
}
