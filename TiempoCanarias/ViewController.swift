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
var nombreCiudad = ""
var climaGlobal:Clima?

class ViewController: UIViewController {

    @IBOutlet weak var ciudadPicker: UIPickerView!
    @IBOutlet weak var climaLabel: UILabel!
    @IBOutlet weak var climaImg: UIImageView!
    @IBOutlet weak var selectBttn: UIPickerView!
    
    var desClima:String?
    var img:String?
    
    var searchActive : Bool = false
    
    let reachability = Reachability.reachabilityForInternetConnection()
    
    var ciudades = [
        Ciudad(nombre: "La Laguna", id: 2511401),
        Ciudad(nombre: "Las Palmas de Gran Canaria", id: 2515270),
        Ciudad(nombre: "Santa Cruz de Tenerife", id: 2511174),
        Ciudad(nombre: "San Sebastian de La Gomera", id: 2511230),
        Ciudad(nombre: "Vallehermoso", id: 2509887)
        ]

    var filtrado = [Ciudad]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //log crash report
        CLSLogv("ViewController.viewDidLoad()", getVaList([1]))
        ciudadPicker.reloadAllComponents()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "playa.jpg")!)
         ciudadPicker.selectRow(ciudades.count/2, inComponent: 0, animated: false)

        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }


    
    @IBAction func SelectBttn(sender: AnyObject) {
        //log crash report
        CLSLogv("ViewController.SelectBttn()", getVaList([1]))
        if reachability.isReachable() {
            
            if filtrado.isEmpty{
                idCiudad = ciudades[ciudadPicker.selectedRowInComponent(0)].id
                nombreCiudad = ciudades[ciudadPicker.selectedRowInComponent(0)].nombre
            }else{
                idCiudad = filtrado[ciudadPicker.selectedRowInComponent(0)].id
                nombreCiudad = filtrado[ciudadPicker.selectedRowInComponent(0)].nombre
            }
        } else {
            let alertController = UIAlertController(title: "Error", message:
                "Fallo en la conexion. \n Compruebe que esta conectado a Internet!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
            }
    
    @IBAction func miPosBttn(sender: AnyObject) {
        
    }

// MARK: - Init ciudadPicker
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if filtrado.isEmpty {
            return ciudades.count
        }else{
            return filtrado.count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if filtrado.isEmpty {
            return ciudades[row].nombre
        }else{
            return filtrado[row].nombre
        }

    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        // Cuando seleccionas en el picker view       
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        var titleData: String
        if filtrado.isEmpty {
            
            titleData = ciudades[row].nombre
            pickerLabel.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.4)

        }else {
            titleData = filtrado[row].nombre
            pickerLabel.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.4)

        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Helvetica neue", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        return pickerLabel
    }
    
    
// MARK: - Init Search Bar
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        filtrado = [Ciudad]()
        for ciudad in ciudades {
            let tmp: NSString = ciudad.nombre
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            if range.location != NSNotFound {
                filtrado.append(ciudad)
            }
        }

        if(filtrado.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.ciudadPicker.reloadAllComponents()
      ciudadPicker.selectRow(1, inComponent: 0, animated: true)
    }
    
// MARK: - Init Struct Ciudad
    
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

