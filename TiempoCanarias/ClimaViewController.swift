//
//  ClimaViewController.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 1/4/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import UIKit

 var clima:Clima?

class ClimaViewController: UIViewController {

    @IBOutlet weak var imgenView: UIImageView!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var temp_minLabel: UILabel!
    @IBOutlet weak var temp_maxLabel: UILabel!
    @IBOutlet weak var humedadLabel: UILabel!
    @IBOutlet weak var vientoLabel: UILabel!
    
    @IBOutlet weak var cargandoView: UIActivityIndicatorView!
    
    lazy var serviceData = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo1.jpg")!)
        SwiftSpinner.show("Cargando datos de hoy...")
        cargandoView.startAnimating()
        println("Hola view Clima tu ciudad es:\(idCiudad)")
        if clima == nil || idCiudad != clima!.id! {
             self.requestClima()
        }
       
        // Do any additional setup after loading the view.
    }

    
    
    func requestClima() {
        let urlString = "http://api.openweathermap.org/data/2.5/weather?id=\(idCiudad)&lang=sp&units=metric"
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let connection = NSURLConnection(request: request, delegate: self)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        serviceData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var json = NSJSONSerialization.JSONObjectWithData(serviceData, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        
        clima = Clima.fromCurrentDictionary(json)
        //    println(friends)
        
        mostrarDatos()
        cargandoView.stopAnimating()
        SwiftSpinner.hide()
    }

    func mostrarDatos(){
       // var rutaImg = "http://openweathermap.org/img/w/\(clima!.icono!).png"
        
//        var rutaImg = "http://icons.wxug.com/i/c/k/clear.gif"
//        let url = NSURL(string: rutaImg)
//        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//        imgenView.image = UIImage(data: data!)
        imgenView.image = UIImage(named: "32.png")
        ciudadLabel.text = clima!.ciudad!
        descripcionLabel.text = clima!.descripcion!
        tempLabel.text = String (stringLiteral: "\(clima!.temp!)")
        temp_maxLabel.text = "\(clima!.temp_max!)"
        temp_minLabel.text = "\(clima!.temp_min!)"
        humedadLabel.text = "\(clima!.humedad!)"
        vientoLabel.text = "\(clima!.viento_vel!)"
        
//       var storyboard = UIApplication.sharedApplication.delegate.window.rootViewController.storyboard
        var storyboard = UIApplication.sharedApplication().delegate?.window!?.rootViewController?.storyboard
        (storyboard!.instantiateViewControllerWithIdentifier("climaTab")as! ClimaTabViewController).navItem.title = "MEWKEJNAJKEAWIE"
//        climaTab.navItem.title = clima!.ciudad!
//        println("Texto desde view del tab : \(climaTab.navItem.title!)")
//
//        climaTab.navItem.title = "JODERR"
        self.navigationItem.title = clima?.ciudad!
        
    }
    
    
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
