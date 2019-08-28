//
//  MapViewController.swift
//  PickUp
//
//  Created by Anushrut Shah on 16/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var MapView: MKMapView!
    let locationManager = CLLocationManager()
    var prevLocation: CLLocation?
    var directionsArr: [MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func directionButton(_ sender: Any) {
        directions()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MapView.delegate = self
        locationServices()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // TIP: read up on MKAnnotationView, and figure out the best way to display the Favorite button in the annotation view's callout view.
        if annotation is MKUserLocation {
            return nil
        }
        let annotateView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "place")
        return annotateView
    }
    
    /*
     * This MKMapViewDelegate method will be triggered when the user taps on the Favorite button in the annotation callout view.
     */
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            MapView.showsUserLocation = true;
            zoomInOnUser()
            locationManager.startUpdatingLocation()
            prevLocation = centreLocation(for: MapView)
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        case .restricted:
            break
            
        }
    }
    
    func centreLocation(for MapView: MKMapView) -> CLLocation {
        let lat = MapView.centerCoordinate.latitude
        let long = MapView.centerCoordinate.longitude
        return CLLocation(latitude: lat, longitude: long)
    }
    
    func locationServices() {
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkAuthorization()
        } else {
            //Alert user
        }
    }
    
    func zoomInOnUser() {
        if let location = locationManager.location?.coordinate {
            let section = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
            MapView.setRegion(section, animated: true)
        }
    }
    
    func directions() {
        guard let location = locationManager.location?.coordinate else {
            return 
        }
        
        let request = directionsRequest(from: location)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        directions.calculate{ [unowned self] (response, error) in
            guard let response = response else {return}
            
            for route in response.routes{
                self.MapView.addOverlay(route.polyline)
                self.MapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func directionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destCood = centreLocation(for: MapView).coordinate
        let startCood = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destCood)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startCood)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .walking
        request.requestsAlternateRoutes = false
        return request
    }
    
    func resetMapView(withNew directions: MKDirections) {
       MapView.removeOverlays(MapView.overlays)
        directionsArr.append(directions)
        for direction in directionsArr {
            direction.cancel()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else {
            return
        }
        let center = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
        let section = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        MapView.setRegion(section, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorization()
    }
    
    func mapView(_ MapView: MKMapView, regionDidChangeAnimated animated: Bool){
        let centre = centreLocation(for: MapView)
        let geoCoder = CLGeocoder()
        
        guard let prevLocation = self.prevLocation else {return}
        
        guard centre.distance(from: prevLocation) > 100 else {return}
        self.prevLocation = centre
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(centre) { [weak self] (placemarks, error) in
            guard let self = self else {return}
            
            if let _ = error {
                return
            }
            
            guard let placemark = placemarks?.first else {
                return
            }
            
            let streetNum = placemark.subThoroughfare ?? ""
            let street = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.address.text = "\(streetNum) \(street)"
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
