//
//  CallViewModelTests.swift
//  RogerVoiceTests
//
//  Created by Ines BOKRI on 25/11/2024.
//

import XCTest
@testable import RogerVoice

final class CallViewModelTests: XCTestCase {
    
    var viewModel: CallViewModel!
    var mockCallRepository: MockCallRepository!
    var mockTranscriptionRepository: MockTranscriptionRepository!
    
    override func setUp() {
        super.setUp()
        mockCallRepository = MockCallRepository()
        mockTranscriptionRepository = MockTranscriptionRepository()
        viewModel = CallViewModel(callRepository: mockCallRepository, transcriptionRepository: mockTranscriptionRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCallRepository = nil
        mockTranscriptionRepository = nil
        super.tearDown()
    }

    func testLoadCallsAndTranscriptionsSuccess() {
        /// GIVEN
        let mockCall = Call(uuid: "1234", phoneNumber: "0678267833", startDate: "01Janvier2024", endDate: nil, direction: .incoming, status: .notReached)
        let mockTranscription = Transcription(uuid: "123", callUuid: "1234", direction: .incoming, text: "This is Ines")
        
        mockCallRepository.mockCalls = [mockCall]
        mockTranscriptionRepository.mockTranscriptions = [mockTranscription]
        
        /// WHEN
        let expectation = XCTestExpectation(description: "Data is updated")
        viewModel.onDataUpdated = {
            XCTAssertEqual(self.viewModel.calls.count, 1)
            XCTAssertEqual(self.viewModel.transcriptions.count, 1)
            expectation.fulfill()
        }
 
        // THEN
        viewModel.loadCallsAndTranscriptions()
        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadCallsFailure() {
        /// GIVEN
        mockCallRepository.shouldReturnError = true
        
        /// WHEN
        let expectation = XCTestExpectation(description: "Error is handled")
        viewModel.onError = { errorMessage in
            XCTAssertNotNil(errorMessage)
            expectation.fulfill()
        }
        
        /// THEN
        viewModel.loadCallsAndTranscriptions()
        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadTranscriptionsFailure() {
        /// GIVEN
        let mockCall = Call(uuid: "1234", phoneNumber: "0678267833", startDate: "01Janvier2024", endDate: "02Janvier2024", direction: .incoming, status: .success)
        mockCallRepository.mockCalls = [mockCall]
        mockTranscriptionRepository.shouldReturnError = true
        
        /// WHEN
        let expectation = XCTestExpectation(description: "Error is handled in transcription loading")
        viewModel.onError = { errorMessage in
            XCTAssertNotNil(errorMessage)
            expectation.fulfill()
        }
        
        /// THEN
        viewModel.loadCallsAndTranscriptions()
        wait(for: [expectation], timeout: 1.0)
    }

    func testHasTranscriptions() {
        /// GIVEN
        let mockTranscription = Transcription(uuid: "5678", callUuid: "12345", direction: .outgoing, text: "hello this is Ines")
        
        /// WHEN
        mockTranscriptionRepository.mockTranscriptions = [mockTranscription]
        viewModel.transcriptions = [mockTranscription]

        /// THEN
        XCTAssertTrue(viewModel.hasTranscriptions(for: "12345"))
        XCTAssertFalse(viewModel.hasTranscriptions(for: "X2h2k"))
    }
}

