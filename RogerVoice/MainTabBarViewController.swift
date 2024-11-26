//
//  MainTabBarViewController.swift
//  RogerVoice
//
//  Created by Ines BOKRI on 18/11/2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        changeTabBarBackgroundColor()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        adjustTabBarHeight()
    }

    // MARK: Functions
    private func setupViews() {
        let callStoryboard = UIStoryboard(name: "CallViewController", bundle: nil)
        guard let callsVC = callStoryboard.instantiateViewController(withIdentifier: "CallViewController") as? CallViewController else { return }
        callsVC.tabBarItem = UITabBarItem(
            title: "Récents",
            image: UIImage(named: "recents-inactive")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "recents-active")?.withRenderingMode(.alwaysOriginal)
        )
        
        let callsNavController = UINavigationController(rootViewController: callsVC)
        
        let settingsStoryboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        guard let settingsVC = settingsStoryboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        settingsVC.tabBarItem = UITabBarItem(
            title: "Paramètres",
            image: UIImage(named: "settings-inactive")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "settings-active")?.withRenderingMode(.alwaysOriginal)
        )

        let settingsNavController = UINavigationController(rootViewController: settingsVC)
        
        // relier le délégué
        settingsVC.delegate = callsVC

        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor(hex: "1CCAB3")], for: .selected)
        
        viewControllers = [callsNavController, settingsNavController]
    }
    
    private func adjustTabBarHeight() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 113
        tabFrame.origin.y = self.view.frame.size.height - 113
        self.tabBar.frame = tabFrame
    }
    
    private func changeTabBarBackgroundColor() {
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .clear
    }
}

