//
//  LocationViewController.swift
//  ISSPosition
//
//  Created by Shashi Chunara on 10/08/22.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var mapView: MKMapView!
    
    //MARK: Private variables
    private var locationViewModel: LocationViewModel?
    
    //MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    //MARK: Button Click method
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        callGetLocationAPI()
    }
    
    //MARK: User defined method
    func setupView() {
        self.locationViewModel = LocationViewModel()
        locationViewModel?.bindViewModelToController = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    func updateDataSource(){
        guard let locationVM = locationViewModel,
              let loc = locationVM.location,
              let position = loc.issPosition else {
            return
        }
        
        DispatchQueue.main.async {[weak self] in
            self?.setAnnonation(position: position)
        }
    }
    
    func setAnnonation(position: Position) {
        let annotations = MKPointAnnotation()
            annotations.title = "Space Station"
            annotations.coordinate = CLLocationCoordinate2D(
                latitude: position.latitude,
                longitude: position.longitude
            )
        mapView.addAnnotation(annotations)
        centerMaView(coor: annotations.coordinate)
    }
    
    func centerMaView(coor: CLLocationCoordinate2D) {
        mapView.centerCoordinate = coor
    }
    
    func callGetLocationAPI() {
        locationViewModel?.callAPIToGetLocation()
    }
}
