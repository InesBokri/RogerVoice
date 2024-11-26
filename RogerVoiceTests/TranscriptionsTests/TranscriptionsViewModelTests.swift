//
//  TranscriptionsViewModelTests.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 25/11/2024.
//

import XCTest
@testable import RogerVoice

final class TranscriptionsViewModelTests: XCTestCase {
    
    var viewModel: TranscriptionsViewModel!
    
    override func setUp() {
        super.setUp()
        // Initialisation d'un ViewModel par défaut pour les tests
        let mockTranscriptions = [
            Transcription(uuid: "5678", callUuid: "12345", direction: .outgoing, text: "hello this is Ines"),
            Transcription(uuid: "00087", callUuid: "2344", direction: .incoming, text: "I'm Ines BOKRI and you?")
        ]
        let phoneNumber = "0634567890"
        let callDate = "2024-11-25T12:34:56Z"
        viewModel = TranscriptionsViewModel(transcriptions: mockTranscriptions, phoneNumber: phoneNumber, callDate: callDate)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testViewModelInitialization() {
        // Vérifier que les propriétés sont correctement initialisées
        XCTAssertEqual(viewModel.transcriptions.count, 2)
        XCTAssertEqual(viewModel.phoneNumber, "0634567890")
        XCTAssertEqual(viewModel.callDate, "2024-11-25T12:34:56Z")
    }
}

