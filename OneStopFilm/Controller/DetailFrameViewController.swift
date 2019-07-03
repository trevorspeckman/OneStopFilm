//
//  DetailFrameViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/2/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import Mapbox

class DetailFrameViewController: UIViewController {

    let detailFrameModel = DetailFrameModel()
    
    
//MARK: Subview definitions
    fileprivate let mapView: MGLMapView = {
        let map = MGLMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Set the map’s center coordinate and zoom level.
        map.setCenter(CLLocationCoordinate2D(latitude: 40.7326808, longitude: -73.9843407), zoomLevel: 12, animated: false)

        map.styleURL = MGLStyle.lightStyleURL
        // Set the delegate property of our map view to `self` after instantiating it.


        // Declare the marker `hello` and set its coordinates, title, and subtitle.
        let hello = MGLPointAnnotation()
        hello.coordinate = CLLocationCoordinate2D(latitude: 40.7326808, longitude: -73.9843407)
        hello.title = "Hello world!"
        hello.subtitle = "Welcome to my marker"

        // Add marker `hello` to the map.
        map.addAnnotation(hello)
        return map
    }()
    
    fileprivate let table: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.backgroundColor = .red
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false;
        return tableView
    }()
    
    fileprivate let addShotButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Theme.Color.yellow
        button.setTitle("Add Shot", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        table.delegate = self
        table.dataSource = self
        
        view.backgroundColor = Theme.Color.background
        
        setupNavBar()
        setupLayouts()

    }
    
    

    

    
    
//MARK: Setup Methods
    fileprivate func setupNavBar() {
        // Do any additional setup after loading the view.
        self.navigationItem.setTitle("TRIP TO YOSEMITE", subtitle: "Frame 1 of 24")
    }
    
    private func setupLayouts() {
        view.addSubview(mapView)
        view.addSubview(table)
        view.addSubview(addShotButton)
        
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor , multiplier: 0.25).isActive = true
        
        //mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        table.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: addShotButton.topAnchor, constant: -10).isActive = true


        addShotButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        addShotButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        addShotButton.heightAnchor.constraint(equalTo: view.heightAnchor , multiplier: 0.05).isActive = true
         addShotButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true

    }

}

//MARK: Mapbox Delegate Methods
extension DetailFrameViewController: MGLMapViewDelegate {
    // Use the default marker. See also: our view annotation or custom marker examples.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }

    // Allow callout view to appear when an annotation is tapped.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}




extension DetailFrameViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailFrameModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = detailFrameModel.items[indexPath.row]
        item.register(in: tableView)
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        item.configure(cell: cell)
        return cell

    }




    //MARK: Delegate Methods

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}
