//
//  FramesTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class FramesTableViewController: UITableViewController {

    let framesArray = [Frame]()
    let cellId = "cellId"
    
//    var navBarColorName = "" {
//        didSet{
//            if let pageColorName = Color.gradientDictionary[navBarColorName] {
//                let pageColor = pageColorName.colorOne
//                self.navigationController?.navigationBar.barTintColor = pageColor
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        UILabel.appearance(whenContainedInInstancesOf: [FramesTableViewCell.self]).backgroundColor = .green
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if let navigationBar = self.navigationController?.navigationBar {
                navigationBar.setGradientBackgroundImage(colorOne: Theme.current.cellColor, colorTwo: Theme.current.cellColor)
        }
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.textColor, NSAttributedString.Key.font: Theme.Font.titleFont!]
        self.navigationController?.navigationBar.tintColor = Theme.current.textColor
        self.navigationController?.navigationBar.barStyle = Theme.current.barStyle
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return framesArray.count == 0 ? 1 : framesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! FramesTableViewCell
        return cell
        
    }
    
    
    
    
    //MARK: Delegate Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BaseTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailFrameViewController = DetailFrameViewController()
        navigationController?.pushViewController(detailFrameViewController, animated: true)
    }
    
    
    
    //MARK: Setup Methods
    fileprivate func setupNavBar() {
        navigationItem.title = "TRIP TO YOSEMITE"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: Theme.Font.titleFont!]
        if let navigationBar = self.navigationController?.navigationBar {
            let gradientColors = ActiveRollTheme.current
               navigationBar.setGradientBackgroundImage(colorOne: gradientColors.colorOne, colorTwo: gradientColors.colorTwo)
        }
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
    }
    
//    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
//        var gradientImage:UIImage?
//        UIGraphicsBeginImageContext(gradientLayer.frame.size)
//        if let context = UIGraphicsGetCurrentContext() {
//            gradientLayer.render(in: context)
//            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
//        }
//        UIGraphicsEndImageContext()
//        return gradientImage
//    }
    
    fileprivate func setupTableView() {
        
        tableView.register(FramesTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Theme.current.backgroundColor
    }
    
   

}




