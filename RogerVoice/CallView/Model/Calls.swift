//
//  Calls.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 21/11/2024.
//

import Foundation

import Foundation

enum CallDirection: Int, Codable {
    case outgoing = 0
    case incoming = 1
}

enum CallStatus: Int, Codable {
    case success = 0
    case missed = 1
    case rejected = 2
    case notReached = 3
}

struct Call: Codable {
    let uuid: String
    let phoneNumber: String
    let startDate: String
    let endDate: String?
    let direction: CallDirection
    let status: CallStatus
}

struct CallResponse: Codable {
    let call: [Call]
}
