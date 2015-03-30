//
//  ViewController.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 30/3/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capturaTexto: UITextField!
    @IBOutlet weak var ciudadPicker: UIPickerView!
    
    let ciudades = ["Santa Cruz", "La Laguna"]
    
    var ciudades2 = [
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
        println(ciudades2[ciudadPicker.selectedRowInComponent(0)].id)

    }


    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ciudades2.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return ciudades2[row].nombre
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

