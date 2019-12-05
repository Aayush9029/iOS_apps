//
//  ViewController.swift
//  encrypt_iOS
//
//  Created by Aayush Pokharel on 2019-11-29.
//  Copyright © 2019 Aayush Pokharel. All rights reserved.
//

import UIKit
import Foundation
  

import UIKit
import MapKit

    
class ViewController: UIViewController {


    struct CurrentLocalWeather: Decodable {
             let base: String
             let clouds: Clouds
             let main: Main
             let name: String
             let visibility: Int
             let weather: [Weather]
             let wind: Wind
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
    @IBOutlet weak var Date_Time_lbl: UILabel!  //format cha hai
    
    
    func getWeather(city: String, lat:Double, lon:Double) {
   
        
//        city is for later when i add search location thingy

        guard let weatherRequestURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?APPID=bc491408821cc43317006173fd1c5bef&units=metric&lat=" + String(lat) + "&lon=" + String(lon)) else {print("err in url");return}
        
//        print(weatherRequestURL)
            //    let weatherRequestURL = URL(string: "\  }
            
     //
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
            

//            print("main time _____>")
//
//            print(obj.main)
//            print(" time _____>")
//            print(obj.weather[0].description)
//            print("  _____>")
//
//
            DispatchQueue.main.async {
                self.ctlbl.text = String(Int(obj.main.temp)) + "°"  //current temp label
                self.desc_lbl.text = String(obj.weather[0].description)  //description  label
                self.humid_lbl.text = "Humidity: " + String(Int(obj.main.humidity))  + "%"//current temp label
                self.wind_lbl.text =  "Wind: " + String(obj.wind.speed) + " m/s"//current temp label
                self.pressure_lbl.text =  "Pressure: " + String(obj.main.pressure) + " hPa" //current temp label
                self.minmax_lbl.text = String(Int(obj.main.tempMin))  + "°" + " / " + String(Int(obj.main.tempMax))  + "°" //current temp label
                self.cloud_lbl.text =  "Clouds: " + String(obj.clouds.all) + "%"//current temp label

            }
  
            
        }
        }
         task.resume()
       }

  override func viewDidLoad() {

    super.viewDidLoad()
     locManager.requestWhenInUseAuthorization()
    
    _ =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
    let days = ["Sun", "Mon", "Tue","Wed", "Thu","Fri", "Sat",]
       let date = Date()
          let format = DateFormatter()
          format.dateFormat = "d HH:mm"
          let formattedDate = format.string(from: date)
       let calendar = Calendar.current
           let day = calendar.component(.weekday, from: date)
    self.Date_Time_lbl.text = (days[day] + ", " + String(formattedDate))

    }

   
    
              //use your params

    
    
    
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



//this is stupid but this works i hate swift (i need to learn a lot) miss pythona and js <3
