//
//  MapaViewController.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 2/4/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapa: MKMapView!
    

    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
//        var locationManager = CLLocationManager()
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManage.requestWhenInUseAuthorization()
        
        //Anotacion en el mapa
       
        var anotacion = MKPointAnnotation()
        
        var latitud:CLLocationDegrees = clima!.latitud!
        var longitud:CLLocationDegrees = clima!.longitud!
        
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud, longitud)
        anotacion.coordinate = location
        
        anotacion.title = clima?.ciudad!
        anotacion.subtitle = clima?.descripcion!
        
        //        var imagenAnotacion = MKAnnotationView()
        //
        //        imagenAnotacion.image = UIImage(named: "32.png")
        //        imagenAnotacion.annotation = anotacion
        //        imagenAnotacion.canShowCallout = true
        
        mapa.addAnnotation(anotacion as MKAnnotation)
        
        //Muestre zoom entre los 2 puntos de mapa
        var userCoord = locationManager.location.coordinate
        var pointUser = MKMapPointForCoordinate(userCoord)
        // var pointUser = MKMapPointForCoordinate(locationManager.location.coordinate)
        var rectUser = MKMapRectMake(pointUser.x, pointUser.y, 1, 1)
        
        var pointAnn = MKMapPointForCoordinate(anotacion.coordinate)
        var rectAnn = MKMapRectMake(pointAnn.x, pointAnn.y, 1, 1)
        
        
        var union = MKMapRectUnion(rectUser, rectAnn)
        
        mapa.setVisibleMapRect(union, edgePadding: UIEdgeInsetsMake(50, 50, 50, 50) , animated: true)

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
            }

    
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
            
            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }
            println("HOLAAA")
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.animatesDrop = true
                pinView!.pinColor = .Purple
                var rutaImg = "http://openweathermap.org/img/w/\(clima!.icono!).png"
                let url = NSURL(string: rutaImg)
                let data = NSData(contentsOfURL: url!)
                pinView!.leftCalloutAccessoryView = UIImageView(image: UIImage(data: data!))
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
    }
    
    //Funcion cuando nos movemos
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        
//        println(locations)
//        
//        //Nuestra posicion actualmente
//        var miPosicion:CLLocation = locations[0] as CLLocation
//        
//        var latitud = miPosicion.coordinate.latitude
//        var longitud = miPosicion.coordinate.longitude
//        
//        //Distancia de latitud entre los bordes de la pantalla mismo longitud- Cuanto mas pequenyo mas zoom
//        var latDelta:CLLocationDegrees = 0.0001
//        var lonDelta:CLLocationDegrees = 0.0001
//        
//        
//        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
//        
//        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud, longitud)
//        
////        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        var region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location,1000, 1000)
//
//        self.mapa.setRegion(region, animated: true)
//    }
    
//    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
//        var region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate ,1000, 1000)
//        println("HOLLA")
//        mapView.setRegion(region, animated: true)
//    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
