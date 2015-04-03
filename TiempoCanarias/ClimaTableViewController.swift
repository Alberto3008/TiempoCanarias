//
//  ClimaTableViewController.swift
//  TiempoCanarias
//
//  Created by Alberto Mendoza on 1/4/15.
//  Copyright (c) 2015 Alberto Mendoza. All rights reserved.
//

import UIKit

class ClimaTableViewController: UITableViewController {

    var climas: [Clima]?
    lazy var serviceData = NSMutableData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("hola climaTabla! tu ciudad es:\(idCiudad)")
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "laplaya.png")!)
        requestClima()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func requestClima() {
        let urlString = "http://api.openweathermap.org/data/2.5/forecast/daily?id=\(idCiudad)&cnt=7&mode=json&units=metric&lang=sp"
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let connection = NSURLConnection(request: request, delegate: self)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        serviceData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var json = NSJSONSerialization.JSONObjectWithData(serviceData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        climas = Clima.fromForecastDictionary(json)
        //    println(friends)
        
        tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return (climas == nil) ? 0 : climas!.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClimaDiaCell", forIndexPath: indexPath) as ClimaTableViewCell
        let clima = climas![indexPath.row]
        
        var rutaImg = "http://openweathermap.org/img/w/\(clima.icono!).png"
        let url = NSURL(string: rutaImg)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        cell.imageView!.image = UIImage(data: data!)
        cell.descripcionLabel!.text = clima.descripcion!
        
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE"
        let local = NSLocale(localeIdentifier: "es_ES")
        dayTimePeriodFormatter.locale = local
        var dateString = dayTimePeriodFormatter.stringFromDate(clima.fecha!)
        dateString = mayusculas(dateString)
        cell.fechaLabel!.text = dateString
        
        return cell
    }
    
    
    func mayusculas(string:String)->String{
        var resul = string
        resul.replaceRange(resul.startIndex...resul.startIndex, with: String(resul[resul.startIndex]).capitalizedString)
        return resul
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
