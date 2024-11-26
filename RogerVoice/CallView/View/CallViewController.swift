//
//  CallViewController.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 18/11/2024.
//

import UIKit
import SwiftUI

class CallViewController: UIViewController, SettingsViewControllerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var emptyCallView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let viewModel = CallViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTableView()
        viewModel.loadCallsAndTranscriptions()
        setupBindings()
    }
    
    // MARK: - Functions
    private func setupViews() {
        view.backgroundColor = UIColor(hex: "F2F2F2")
        self.emptyCallView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CallCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "CallCell")
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            
            let isEmpty = self.viewModel.isCallsEmpty
            self.emptyCallView.isHidden = !isEmpty
            self.tableView.isHidden = isEmpty
            
            self.tableView.reloadData()
        }
        
        viewModel.onError = { errorMessage in
            self.showAlert(with: errorMessage)
        }
    }

    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - SettingsViewControllerDelegate
    func didTapClearCalls() {
        viewModel.calls.removeAll()
        emptyCallView.isHidden = false
        tableView.isHidden = true
    }

    func didTapLoadCalls() {
        viewModel.loadCallsAndTranscriptions()
    }
}

    // MARK: - UITableViewDataSource
extension CallViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.calls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CallCell", for: indexPath) as? CallCell else { return UITableViewCell() }
        
        let call = viewModel.calls[indexPath.row]
        cell.setupCell(with: call, transcriptions: viewModel.transcriptions)

        return cell
    }
}

    // MARK: - UITableViewDelegate
extension CallViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let call = viewModel.calls[indexPath.row]
        
        if viewModel.hasTranscriptions(for: call.uuid) {
            let transcriptionsView = TranscriptionsView(viewModel: TranscriptionsViewModel(transcriptions: viewModel.transcriptions(for: call.uuid), phoneNumber: call.phoneNumber, callDate: call.startDate))
            
            let hostingController = UIHostingController(rootView: transcriptionsView)
            hostingController.hidesBottomBarWhenPushed = true
            
            navigationController?.pushViewController(hostingController, animated: true)
        }
    }
}
