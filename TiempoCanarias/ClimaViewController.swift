//
//  ClimaViewController.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 1/4/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import UIKit

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
    var clima:Clima?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "laplaya.png")!)
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
        var json = NSJSONSerialization.JSONObjectWithData(serviceData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        clima = Clima.fromCurrentDictionary(json)
        //    println(friends)
        
        mostrarDatos()
        cargandoView.stopAnimating()
    }

    func mostrarDatos(){
        var rutaImg = "http://openweathermap.org/img/w/\(clima!.icono!).png"
        let url = NSURL(string: rutaImg)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        imgenView.image = UIImage(data: data!)
        ciudadLabel.text = clima!.ciudad!
        descripcionLabel.text = mayusculas(clima!.descripcion!)
        tempLabel.text = String (stringLiteral: "\(clima!.temp!)")
        temp_maxLabel.text = "\(clima!.temp_max!)"
        temp_minLabel.text = "\(clima!.temp_min!)"
        humedadLabel.text = "\(clima!.humedad!)"
        vientoLabel.text = "\(clima!.viento_vel!)"
        
    }
    
    func mayusculas(string:String)->String{
        var resul = string
        resul.replaceRange(resul.startIndex...resul.startIndex, with: String(resul[resul.startIndex]).capitalizedString)
        return resul
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