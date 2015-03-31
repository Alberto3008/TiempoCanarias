//
//  ViewController.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 30/3/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ciudadPicker: UIPickerView!
    @IBOutlet weak var climaLabel: UILabel!
    var clima:String?
    
    var ciudades = [
        Ciudad(nombre: "La Laguna", id: 2511401),
        Ciudad(nombre: "Las Palmas de Gran Canaria", id: 2515270),
        Ciudad(nombre: "Santa Cruz de Tenerife", id: 2511174),
        Ciudad(nombre: "San Sebastian de La Gomera", id: 2511230),
        Ciudad(nombre: "Vallehermoso", id: 2509887)
        ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ciudadPicker.reloadAllComponents()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "laplaya.png")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func tiempoBttn(sender: AnyObject) {
        println(ciudades[ciudadPicker.selectedRowInComponent(0)].id)
        tiempoWebService()

    }


    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ciudades.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return ciudades[row].nombre
    }
    
    struct Ciudad
    {
        var nombre : String
        var id : NSInteger
        init(nombre : String, id : NSInteger)
        {
            self.nombre = nombre
            self.id = id
        }
    }
    
    
    func tiempoWebService(){
       let urlPath = "http://api.openweathermap.org/data/2.5/weather?id=\(ciudades[ciudadPicker.selectedRowInComponent(0)].id)&lang=sp&units=metric"
          println(urlPath)
        let url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            
            if(error != nil){
                //Imprime si hay un error por consola
                println(error.localizedDescription)
            }
            
           var nsdata:NSData = NSData(data:data)

           self.recuperarClima(nsdata)
            
            dispatch_async(dispatch_get_main_queue(),{ println(self.clima!); self.climaLabel.text = self.clima!})
            
        })
        
        task.resume()
        
        
        
        
        
    }
    
    func recuperarClima(nsdata:NSData){
        
        let jsonCompleto : AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        
        println(jsonCompleto)
        
        let arregloJsonClima = jsonCompleto["weather"]
        
        if let jsonArray = arregloJsonClima as? NSArray{
            
            //Recorre por el array de la respues de json del servidor
            jsonArray.enumerateObjectsUsingBlock({model, index, stop in
                 self.clima = model["description"] as? String
            });
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

