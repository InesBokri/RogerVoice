//
//  SettingsViewController.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 18/11/2024.
//

import UIKit

// MARK: - SettingsViewControllerDelegate
protocol SettingsViewControllerDelegate: AnyObject {
    func didTapClearCalls()
    func didTapLoadCalls()
}

// MARK: - SettingsViewController
class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loadCallButton: UIButton!
    @IBOutlet weak var clearCallsButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    // MARK: - Functions
    private func setupView() {
        view.backgroundColor = UIColor(hex: "F2F2F2")
        mainView.layer.cornerRadius = 20
        mainView.clipsToBounds = true
        
        let loadCallTitle = NSAttributedString(
            string: "CHARGER LES APPELS",
            attributes: [
                .foregroundColor: UIColor(hex: "13383B"),
                .font: UIFont.boldSystemFont(ofSize: 18)
            ]
        )
        loadCallButton.setAttributedTitle(loadCallTitle, for: .normal)
        loadCallButton.setTitleColor(.gray, for: .highlighted)
        loadCallButton.layer.cornerRadius = 12
        loadCallButton.clipsToBounds = true
        
        let clearCallsTitle = NSAttributedString(
            string: "VIDER LES APPELS",
            attributes: [
                .foregroundColor: UIColor(hex: "616D70"),
                .font: UIFont.boldSystemFont(ofSize: 18)
            ]
        )
        clearCallsButton.setAttributedTitle(clearCallsTitle, for: .normal)
        clearCallsButton.setTitleColor(.gray, for: .highlighted)
        clearCallsButton.layer.borderColor = UIColor(hex: "BCC5C8").cgColor
        clearCallsButton.layer.borderWidth = 1
        clearCallsButton.layer.cornerRadius = 12
        clearCallsButton.clipsToBounds = true
    }
    
    // MARK: - IBActions
    @IBAction func loadCallButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }

        delegate.didTapLoadCalls()
    }

    @IBAction func clearCallsButtonTapped(_ sender: UIButton) {
        guard let delegate = delegate else { return }

        delegate.didTapClearCalls()
    }
}
