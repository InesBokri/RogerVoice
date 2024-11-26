//
//  CallCell.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 22/11/2024.
//

import UIKit

class CallCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var callStatusImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var transcriptionImageView: UIImageView!
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func setupCell(with call: Call, transcriptions: [Transcription]) {
        phoneNumberLabel.text = call.phoneNumber.formatPhoneNumber()
        if call.status != .success {
            callStatusImageView.image = UIImage(named: "cross-close")
        } else {
            callStatusImageView.image = UIImage(named: call.direction == .incoming ? "incoming" : "outgoing")
        }
        // Formatte la date et met à jour le timeLabel
        if let formattedDate = call.startDate.formattedDate() {
            timeLabel.text = formattedDate
        } else {
            timeLabel.text = "Date invalide" // placeholder en cas d'erreur
        }
        
        let hasTranscription = transcriptions.contains { $0.callUuid == call.uuid }
        if hasTranscription {
            transcriptionImageView.isHidden = false
        } else {
            transcriptionImageView.isHidden = true
        }
    }
}
