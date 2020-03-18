//
//  ViewController.swift
//  encrypt_iOS
//
//  Created by Aayush Pokharel on 2020-3-.
//  Copyright © 2019 Aayush Pokharel. All rights reserved.
//

import Foundation
import UIKit
import MapKit

    
class ViewController: UIViewController {

    
    var sunriseVar: String = ""
    var sunsetVar: String = ""
    var visVar: String = ""
    var latVar: String = ""
    var lonVar: String = ""
    
    @IBAction func moreInfoButton(_ sender: Any) {
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView" {
            let controller = segue.destination as! DetailsViewController
            
            controller.sunriseVar = sunriseVar
            controller.sunsetVar = sunsetVar
            controller.visVar = visVar
            controller.latVar = latVar
            controller.lonVar = lonVar

        }
    }
    
    struct CurrentLocalWeather: Decodable {
             let base: String
             let clouds: Clouds
             let main: Main
             let name: String
             let visibility: Int
             let weather: [Weather]
             let wind: Wind
             let coord: Coord
             let sys: Sys
        
    }
    
    struct Sys: Decodable {
            let sunrise: Double
            let sunset: Double
        }
    
        struct Coord: Decodable {
            let lat: Double
            let lon: Double
        }
    
         struct Clouds: Decodable {
             let all: Int
         }
    
         struct Main: Decodable {
             let humidity: Int
             let pressure: Int
             let temp: Double
             let tempMax: Float
             let tempMin: Float
             private enum CodingKeys: String, CodingKey {
                 case humidity, pressure, temp, tempMax = "temp_max", tempMin = "temp_min"
             }
         }
         struct Weather: Decodable {
             let description: String
             let icon: String
             let id: Int
             let main: String
         }
         
         struct Wind: Decodable {
             let deg: Int
             let speed: Double
         }
    
    
    
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!

    @IBOutlet weak var city_lbl: UILabel!
    @IBOutlet weak var ctlbl: UILabel!
    @IBOutlet weak var desc_lbl: UILabel!
    @IBOutlet weak var cloud_lbl: UILabel!
    @IBOutlet weak var humid_lbl: UILabel!
    @IBOutlet weak var wind_lbl: UILabel!
    @IBOutlet weak var pressure_lbl: UILabel!
    @IBOutlet weak var minmax_lbl: UILabel!
    @IBOutlet weak var Date_Time_lbl: UILabel!
    
    
    
    func getWeather(city: String, lat:Double, lon:Double) {
           
//        city is for later when i add search location thingy
        guard let weatherRequestURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?APPID=bc491408821cc43317006173fd1c5bef&units=metric&lat=" + String(lat) + "&lon=" + String(lon)) else {print("err in url");return}
        

         // The data task retrieves the data.
            
         let task = URLSession.shared.dataTask(with: weatherRequestURL){ (data, response, error)  in
           if let error = error {
             // Case 1: Error
             // We got some kind of error while trying to get data from the server.
            
             print("Error:\n\(error)")
           }
           else {
             // Case 2: Success
             // We got a response from the server!
     
             let dataString = String(data: data!, encoding: .utf8)
//            print(dataString!)
            
            // Convert the jsonString to .utf8 encoded data.
            let jsonData = dataString!.data(using: .utf8)!

            // Create a JSON Decoder object.
            let decoder = JSONDecoder()

            // Decode the JSON data using the APOD struct we created that follows this data's structure.
            let obj = try! decoder.decode(CurrentLocalWeather.self, from: jsonData)
            

            DispatchQueue.main.async {
                self.ctlbl.text = String(Int(obj.main.temp)) + "°"  //current temp label
                self.desc_lbl.text = String(obj.weather[0].description)  //description  label
                self.humid_lbl.text = "Humidity: " + String(Int(obj.main.humidity))  + "%"//current temp label
                self.wind_lbl.text =  "Wind: " + String(obj.wind.speed) + " m/s"//current temp label
                self.pressure_lbl.text =  "Pressure: " + String(obj.main.pressure) + " hPa" //current temp label
                self.minmax_lbl.text = String(Int(obj.main.tempMin))  + "°" + " / " + String(Int(obj.main.tempMax))  + "°" //current temp label
                self.cloud_lbl.text =  "Clouds: " + String(obj.clouds.all) + "%"//current temp label
                self.city_lbl.text = String(obj.name)
                
                self.visVar = String(obj.visibility/1000)
                

                var date = NSDate(timeIntervalSince1970:  obj.sys.sunrise)
                let dayTimePeriodFormatter = DateFormatter()
                dayTimePeriodFormatter.dateFormat = "hh:mm a"

                var dateString = dayTimePeriodFormatter.string(from: date as Date)
                
                self.sunriseVar = String(dateString)

                date = NSDate(timeIntervalSince1970: obj.sys.sunset)
                dayTimePeriodFormatter.dateFormat = "hh:mm a"
                dateString = dayTimePeriodFormatter.string(from: date as Date)
                
                self.sunsetVar = String(dateString)

                
                self.latVar = String(obj.coord.lat)
                self.lonVar = String(obj.coord.lon)

            }
        }
        }
         task.resume()
       }
    
    func dateUpdate(){
        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
           let date = Date()
              let format = DateFormatter()
              format.dateFormat = "d, HH:mm a"
              let formattedDate = format.string(from: date)
           let calendar = Calendar.current
               let day = calendar.component(.weekday, from: date)
        self.Date_Time_lbl.text = (days[day-1] + " " + String(formattedDate))
    }

  override func viewDidLoad() {

    super.viewDidLoad()
     locManager.requestWhenInUseAuthorization()
    dateUpdate()
    
    _ =  Timer.scheduledTimer(withTimeInterval: 55.9, repeats: true) { (timer) in
        self.dateUpdate()

    }

     if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
         CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
         guard let currentLocation = locManager.location else {
             return
         }
//         print(currentLocation.coordinate.latitude)
//         print(currentLocation.coordinate.longitude)
        getWeather(city:"toronto", lat:currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)

     }

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}



extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium

        return dateFormatter.string(from: date)
    }
}
