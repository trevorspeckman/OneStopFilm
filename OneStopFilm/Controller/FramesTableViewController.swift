//
//  FramesTableViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/1/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit

class FramesTableViewController: UITableViewController {

    let framesTableModel = FramesTableModel()
    
    var navBarColorName = "" {
        didSet{
            if let pageColorName = Theme.Color.gradientDictionary[navBarColorName] {
                let pageColor = pageColorName[0]
                self.navigationController?.navigationBar.barTintColor = pageColor
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if let navigationBar = self.navigationController?.navigationBar {
                navigationBar.setGradientBackgroundImage(colorOne: .white, colorTwo: .white)
        }
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: Theme.Font.titleFont!]
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return framesTableModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = framesTableModel.items[indexPath.row]
        item.register(in: tableView)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        item.configure(cell: cell)
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
            if let gradientColors = Theme.Color.gradientDictionary[navBarColorName]{
               navigationBar.setGradientBackgroundImage(colorOne: gradientColors[0], colorTwo: gradientColors[1])
            }
        }
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
   

}




