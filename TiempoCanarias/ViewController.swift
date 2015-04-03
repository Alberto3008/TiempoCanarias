//
//  ViewController.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 30/3/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

var idCiudad:NSInteger = 0

class ViewController: UIViewController {

    @IBOutlet weak var ciudadPicker: UIPickerView!
    @IBOutlet weak var climaLabel: UILabel!
    @IBOutlet weak var climaImg: UIImageView!
 
    
    
    var desClima:String?
    var img:String?
    
    
    var ciudades = [
        Ciudad(nombre: "La Laguna", id: 2511401),
        Ciudad(nombre: "Las Palmas de Gran Canaria", id: 2515270),
        Ciudad(nombre: "Santa Cruz de Tenerife", id: 2511174),
        Ciudad(nombre: "San Sebastian de La Gomera", id: 2511230),
        Ciudad(nombre: "Vallehermoso", id: 2509887)
        ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //log crash report
        CLSLogv("ViewController.viewDidLoad()", getVaList([1]))
        ciudadPicker.reloadAllComponents()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "laplaya.png")!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func SelectBttn(sender: AnyObject) {
        //log crash report
        CLSLogv("ViewController.SelectBttn()", getVaList([1]))
        idCiudad = ciudades[ciudadPicker.selectedRowInComponent(0)].id
    }

// MARK: - Init ciudadPicker
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

