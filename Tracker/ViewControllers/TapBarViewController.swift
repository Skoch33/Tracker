//
//  TapBarViewController.swift
//  Tracker
//
//  Created by Semen Kocherga on 31.07.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(true, forKey: "visitedBefore")
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhiteDay
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        
        tabBar.tintColor = .ypBlue
        tabBar.barTintColor = .ypGray
        tabBar.backgroundColor = .ypWhiteDay
        
        tabBar.layer.borderColor = UIColor.ypLightGray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let trackersViewController = TrackersViewController()
        let statisticViewController = StatisticViewController()
        let statisticViewModel = StatisticViewModel()
        statisticViewController.statisticViewModel = statisticViewModel
        
        trackersViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("TrackersViewController.title", comment: ""),
            image: UIImage(named: "Trackers_TabBarIcon_on"),
            selectedImage: nil)
        
        statisticViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("StatisticViewController.title", comment: ""),
            image: UIImage(named: "Statistics_TabBarIcon_off"),
            selectedImage: nil)
        
        let controllers = [trackersViewController, statisticViewController]
        
        viewControllers = controllers
    }
}
