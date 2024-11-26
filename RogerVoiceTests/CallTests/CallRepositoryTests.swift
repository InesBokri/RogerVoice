//
//  CallRepositoryTests.swift
//  RogerVoiceTests
//
//  Created by Ines BOKRI on 25/11/2024.
//

import XCTest
@testable import RogerVoice

final class CallRepositoryTests: XCTestCase {

    var repository: MockCallRepository!

    override func setUp() {
        super.setUp()
        repository = MockCallRepository()
    }

    override func tearDown() {
        repository = nil
        super.tearDown()
    }

    func testFetchCallsSuccess() {
        /// GIVEN
        let mockCall = Call(uuid: "123456", phoneNumber: "0782738912", startDate: "12Avril2024", endDate: nil, direction: .outgoing, status: .missed)
        repository.mockCalls = [mockCall]
        repository.shouldReturnError = false

        let expectation = XCTestExpectation(description: "Fetch calls succeeds")
        /// WHEN
        repository.fetchCalls { result in
            switch result {
                /// THEN
            case .success(let calls):
                XCTAssertEqual(calls.count, 1)
                XCTAssertEqual(calls.first?.uuid, "123456")
                XCTAssertEqual(calls.first?.direction, .outgoing)
            case .failure:
                XCTFail("Expected success, but got failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCallsFailure() {
        /// GIVEN
        repository.shouldReturnError = true

        /// WHEN
        let expectation = XCTestExpectation(description: "Fetch calls fails")
        repository.fetchCalls { result in
            switch result {
                /// THEN
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "TestError")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
