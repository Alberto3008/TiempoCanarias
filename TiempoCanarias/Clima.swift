//
//  Clima.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 1/4/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import Foundation

class Clima {
    var id:NSInteger?
    var ciudad:String?
    var fecha:NSDate?
    var latitud:Double?
    var longitud:Double?
    var descripcion:String?
    var icono:String?
    var humedad:Double?
    var viento_vel:Double?
    var temp:Double?
    var temp_max:Double?
    var temp_min:Double?
    var estacion:String?
    
    init(id: NSInteger){
        self.id=id
    }
    
    convenience init() {
        self.init(id: 0)
    }
//    // Fecha 
//    
//    var fechaunix = 2131231313
//    var fecha = NSDate (timeIntervalSince1970: fechaunix)
    
    class func fromCurrentDictionary(dictionary: NSDictionary) -> Clima {
        let list = dictionary["weather"] as? NSArray
         let clima = Clima ()
        
        list?.enumerateObjectsWithOptions(NSEnumerationOptions.allZeros, usingBlock: { (item, idx, stop) -> Void in
            
            let ciudad = dictionary["name"] as? String
            let id = dictionary["id"] as? NSInteger
            
            let coordenadas = dictionary["coord"] as NSDictionary
            println("COORDENADAS >>>\(coordenadas)")
            
            let latitud = coordenadas["lat"] as?  Double
            let longitud = coordenadas["lon"] as? Double
            
            var fechaunix = dictionary["dt"] as? NSTimeInterval
            let fecha:NSDate = NSDate (timeIntervalSince1970: fechaunix!)
            
            var main = dictionary["main"] as NSDictionary
            let temp = main["temp"] as? Double
            let temp_max = main["temp_max"] as? Double
            let temp_min = main["temp_min"] as? Double
            let humedad = main["humidity"] as? Double
            
            var descripcion = item["description"] as? String
            var icono = item["icon"] as? String

            
            var viento = dictionary["wind"] as NSDictionary
            let viento_vel = viento["speed"] as? Double
            
           
            clima.id=id
            clima.ciudad=ciudad
            clima.fecha=fecha
            clima.latitud=latitud
            clima.longitud=longitud
            clima.descripcion=mayusculas(descripcion!)
            clima.icono=icono
            clima.humedad=humedad
            clima.viento_vel=viento_vel
            clima.temp=temp
            clima.temp_max=temp_max
            clima.temp_min=temp_min
            
        })
        return clima
    }
    
    class func fromForecastDictionary(dictionary: NSDictionary) -> [Clima] {
        var climas = [Clima]()
        let list = dictionary["list"] as? NSArray
        
        
        list?.enumerateObjectsWithOptions(NSEnumerationOptions.allZeros, usingBlock: { (item, idx, stop) -> Void in
            
            let lugar = dictionary["city"] as NSDictionary
            let ciudad = lugar["name"] as? String
            let id = lugar["id"] as? NSInteger
            
            let coordenadas = lugar["coord"] as NSDictionary
            let latitud = coordenadas["lat"] as?  Double
            let longitud = coordenadas["lon"] as? Double
            
            var fechaunix = item["dt"] as? NSTimeInterval
            let fecha:NSDate = NSDate (timeIntervalSince1970: fechaunix!)
            
            var main = item["temp"] as NSDictionary
            let temp = main["day"] as? Double
            let temp_max = main["max"] as? Double
            let temp_min = main["min"] as? Double
            let humedad = main["humidity"] as? Double
            
            let tiempo = item["weather"] as? NSArray
            
            var descripcion:String = ""
            var icono:String = ""
            
            tiempo?.enumerateObjectsWithOptions(NSEnumerationOptions.allZeros, usingBlock: { (item, idx, stop) -> Void in
                descripcion = item["description"] as String
                icono = item["icon"] as String
            })
            if icono == "01n" { icono = "01d" }
            
            let viento_vel = item["speed"] as? Double
            
            let clima = Clima (id:id!)
            
            clima.ciudad=ciudad
            clima.fecha=fecha
            clima.latitud=latitud
            clima.longitud=longitud
            clima.descripcion = mayusculas(descripcion)
            clima.icono=icono
            clima.humedad=humedad
            clima.viento_vel=viento_vel
            clima.temp=temp
            clima.temp_max=temp_max
            clima.temp_min=temp_min
            climas.append(clima)
            
        })
        return climas
    }



}

func mayusculas(string:String)->String{
    var resul = string
    resul.replaceRange(resul.startIndex...resul.startIndex, with: String(resul[resul.startIndex]).capitalizedString)
    return resul
}