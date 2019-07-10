//
//  TabBarController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 6/21/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let currentRolls = ActiveFilmRollsViewController(collectionViewLayout: layout)
        let logNavController = UINavigationController(rootViewController: currentRolls)
        
        
        let develop = DevelopTableViewController()
        let developNavController = UINavigationController(rootViewController: develop)
        
        let archive = ArchiveCollectionViewController(collectionViewLayout: layout)
        let archiveNavController = UINavigationController(rootViewController: archive)
        
        
        let settings = SettingsTableViewController()
        let settingsNavController = UINavigationController(rootViewController: settings)
        
        
        
        logNavController.tabBarItem.title = "Log"
        developNavController.tabBarItem.title = "Develop"
        archiveNavController.tabBarItem.title = "Archive"
        settingsNavController.tabBarItem.title = "Settings"
        
        logNavController.tabBarItem.image = UIImage(named: "icon_notebook")
        
        viewControllers = [logNavController, developNavController, archiveNavController, settingsNavController]
        
        tabBar.isTranslucent = true
        tabBar.tintColor = Theme.Color.orangeLight
    }
    


}
