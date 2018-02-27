//
//  ZXSoreMapInfoViewController.swift
//  YDHYK
//
//  Created by screson on 2017/10/31.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit


/// 店铺地址-地图
class ZXSoreMapInfoViewController: ZXSTUIViewController,BMKMapViewDelegate,BMKLocationServiceDelegate {

    var bmkMapView: BMKMapView!
    var locationService: BMKLocationService!
    var location: CLLocationCoordinate2D?
    var storeName: String?
    var address: String?
    
    override var preferredCartButtonHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "地图"
        bmkMapView = BMKMapView.init(frame: self.view.frame)
        bmkMapView.showsUserLocation = true
        self.view.addSubview(bmkMapView)
        
        locationService = BMKLocationService()
        
        let locationButton = UIButton.init(type: .custom)
        locationButton.frame = CGRect(x: 10, y: ZX.BOUNDS_HEIGHT - 124, width: 45, height: 45)
        locationButton.setImage(#imageLiteral(resourceName: "store-locate"), for: .normal)
        locationButton.addTarget(self, action: #selector(updateUserLocationAction), for: .touchUpInside)
        self.view.addSubview(locationButton)
    }
    
    func updateUserLocationAction() {
        locationService.startUserLocationService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bmkMapView.delegate = nil
        locationService.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        bmkMapView.delegate = nil
        locationService.delegate = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let location = location {
            self.setMapCenter(coordinate: location)
            let anno = BMKPointAnnotation()
            anno.title = self.storeName ?? "无"
            anno.subtitle = self.address ?? ""
            anno.coordinate = location
            bmkMapView.addAnnotation(anno)
            bmkMapView.selectAnnotation(anno, animated: true)
        } else {
            locationService.startUserLocationService()
            ZXHUD.mbShowFailure(in: self.view, text: "位置信息不存在", delay: ZX.DELAY_INTERVAL)
        }
    }
    
    func setMapCenter(coordinate center:CLLocationCoordinate2D) {
        var span = BMKCoordinateSpan()
        span.latitudeDelta = 0.05
        span.longitudeDelta = 0.05
        var region = BMKCoordinateRegion()
        region.center = center
        region.span = span
        bmkMapView.setRegion(region, animated: true)
    }
    
    //Location Delegtate
    func didUpdate(_ userLocation: BMKUserLocation!) {
        locationService.stopUserLocationService()
        bmkMapView.updateLocationData(userLocation)
        self.setMapCenter(coordinate: locationService.userLocation.location.coordinate)
    }
    
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        locationService.stopUserLocationService()
        bmkMapView.updateLocationData(userLocation)
    }
    
    func didFailToLocateUserWithError(_ error: Error!) {
        locationService.stopUserLocationService()
    }
    
    //MapView Delegate
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if let annoview = mapView.dequeueReusableAnnotationView(withIdentifier: "BMKAnnotationView") {
            return annoview
        } else {
            let annoView = BMKAnnotationView.init()
            return annoView
        }
    }
    
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        print(view.annotation.title!())
    }
    
}
