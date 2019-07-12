//
//  DetailFrameViewController.swift
//  OneStopFilm
//
//  Created by Trevor Speckman on 7/2/19.
//  Copyright © 2019 Trevor Speckman. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder


class DetailFrameViewController: UIViewController {

    let detailFrameModel = DetailFrameModel()
    let reuseIdentifiers = ["LabelWithImageTableViewCell", "IndicatorTableViewCell", "SliderTableViewCell"]
    var previousLocation: CLLocation?
    var labelText: String?
    
//MARK: Subview definitions
    fileprivate let mapView: MGLMapView = {
        let map = MGLMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.tintColor = ActiveRollTheme.current.colorOne
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Set the map’s center coordinate and zoom level.
        

        map.styleURL = MGLStyle.lightStyleURL
        // Set the delegate property of our map view to `self` after instantiating it.
        

        // Declare the marker `hello` and set its coordinates, title, and subtitle.
        let hello = MGLPointAnnotation()
        hello.coordinate = CLLocationCoordinate2D(latitude: 40.7326808, longitude: -73.9843407)
        
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
        button.backgroundColor = ActiveRollTheme.current.colorOne
        button.setTitle("Add Shot", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true, completionHandler: nil)
        table.delegate = self
        table.dataSource = self
        
        view.backgroundColor = Theme.current.backgroundColor
        
        setupNavBar()
        setupTableView()
        setupLayouts()

    }
    
    

    

    
    
//MARK: Setup Methods
    fileprivate func setupNavBar() {
        // Do any additional setup after loading the view.
        self.navigationItem.setTitle("TRIP TO YOSEMITE", subtitle: "Frame 1 of 24")
    }
    
    fileprivate func setupTableView() {
        table.register(LabelWithImageTableViewCell.self, forCellReuseIdentifier: reuseIdentifiers[0])
        table.register(IndicatorTableViewCell.self, forCellReuseIdentifier: reuseIdentifiers[1])
        table.register(SliderTableViewCell.self, forCellReuseIdentifier: reuseIdentifiers[2])
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
    
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        
        let geocoder = Geocoder.shared
        
        if let currentLocation = mapView.userLocation?.location {
            if previousLocation != nil {
                guard currentLocation.distance(from: previousLocation!) > 50 else { return }
            }
            
            self.previousLocation = currentLocation
            let options = ReverseGeocodeOptions(location: currentLocation)
            geocoder.geocode(options) { (placemarks, attribution, error) in
                guard let placemark = placemarks?.first else {
                    return
                }
                
                let addressNumber = placemark.subThoroughfare ?? ""
                let street = placemark.thoroughfare ?? ""
                let city = placemark.place?.name ?? ""
                let state = placemark.administrativeRegion?.name ?? ""
                let country = placemark.country?.name ?? ""
                
                DispatchQueue.main.async {
                    self.labelText = "\(addressNumber) \(street) \(city) \(state) \(country)"
                    self.table.reloadData()
                }
            }
        }
        
        
        
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
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers[0], for: indexPath) as! LabelWithImageTableViewCell
            cell.titleLabel.titleLabel.text = labelText
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers[0], for: indexPath) as! LabelWithImageTableViewCell
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers[1], for: indexPath) as! IndicatorTableViewCell
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers[2], for: indexPath) as! SliderTableViewCell
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers[2], for: indexPath) as! SliderTableViewCell
            return cell
        
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifiers[0], for: indexPath) as! LabelWithImageTableViewCell
            return cell
    }
    
}




    //MARK: Delegate Methods

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}


