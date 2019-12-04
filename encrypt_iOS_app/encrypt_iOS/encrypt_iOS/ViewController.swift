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
        
        print(weatherRequestURL)
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
            
             let data = dataString!.split(separator: ",")
            var i = 0
            for d in data{
                print(d)
                print(i)
                i = i + 1
                print("---------------")
            }

   
            if (data[13].split(separator: ":").count < 3){
                
                let desc = (data[7]).split(separator: "\"")[2]
                               //             print(desc)
                                           DispatchQueue.main.async {
                                                        self.desc_lbl.text = String(desc)
                                                    }
                
                let current_temp = data[11].split(separator: ":")[2].split(separator: "}")[0]
                                           print(String(current_temp))
                                           DispatchQueue.main.async {
                                               self.ctlbl.text = String(Int((Float(current_temp)!))) + "°"
                                           }

                                           
                                            let pressure = data[12].split(separator: ":")[1]
                               //             print(pressure)
                                           DispatchQueue.main.async {
                                                       self.pressure_lbl.text =  "Pressure: " + String(Int((Float(pressure)!))) + "hPa"
                                                   }
                                   //        self.pressure_lbl.text = String(pressure)

                                    //
                                           let humid = data[13].split(separator: ":")[1].split(separator: "}")[0]
                               //             print(humid)
                                           DispatchQueue.main.async {
                                                       self.humid_lbl.text =  "Humidity: " + String(Int((Float(humid)!))) + "%"
                                                   }
                                   //        self.humid_lbl.text = String(humid)


                                            let min = data[14].split(separator: ":")[1]
                               //             print(min)


                                            let max = data[15].split(separator: ":")[1].split(separator: "}")[0]
                               //             print(max)
                                           
                                           DispatchQueue.main.async {
                                               self.minmax_lbl.text = String(Int((Float(min)!))) + " / " + String(Int((Float(max)!)))
                                                             }
                                         let wind = data[17].split(separator: ":")[2]
                               //             print(wind)
                                           DispatchQueue.main.async {
                                                           self.wind_lbl.text =  "Wind: " + String((Float(wind)!)) + " m/s"
                               
                           }

                               
                                           let clouds = data[19].split(separator: ":")[2].split(separator: "}")[0]
                                           print(clouds)
                                           DispatchQueue.main.async {
                                                           self.cloud_lbl.text =  "Chance of rain: " + String(Int((Float(clouds)!)*100)) + "%"
                                                       }
                                           
                                           let city = data[29].split(separator: ":")[1].split(separator:"\"")[0]
                               //                  print(city)
                                                 DispatchQueue.main.async {
                                                   self.city_lbl.text = String(city)
                                                             }

            }else{
                         let desc = (data[3]).split(separator: "\"")[2]
                //             print(desc)
                            DispatchQueue.main.async {
                                         self.desc_lbl.text = String(desc)
                                     }

                             let current_temp = data[11].split(separator: ":")[1].split(separator: "}")[0]
                //            print(type(of:String(current_temp)))
                            DispatchQueue.main.async {
                                self.ctlbl.text = String(Int((Float(current_temp)!))) + "°"
                            }

                    //        self.currentTemp_lbl.text = String(current_temp)
                            
                             let pressure = data[8].split(separator: ":")[1]
                //             print(pressure)
                            DispatchQueue.main.async {
                                        self.pressure_lbl.text =  "Pressure: " + String(Int((Float(pressure)!))) + "hPa"
                                    }
                    //        self.pressure_lbl.text = String(pressure)

                     //
                            let humid = data[9].split(separator: ":")[1].split(separator: "}")[0]
                //             print(humid)
                            DispatchQueue.main.async {
                                        self.humid_lbl.text =  "Humidity: " + String(Int((Float(humid)!))) + "%"
                                    }
                    //        self.humid_lbl.text = String(humid)


                             let min = data[10].split(separator: ":")[1]
                //             print(min)


                             let max = data[11].split(separator: ":")[1].split(separator: "}")[0]
                //             print(max)
                            
                            DispatchQueue.main.async {
                                self.minmax_lbl.text = String(Int((Float(min)!))) + " / " + String(Int((Float(max)!)))
                                              }
                          let wind = data[13].split(separator: ":")[2]
                //             print(wind)
                            DispatchQueue.main.async {
                                            self.wind_lbl.text =  "Wind: " + String((Float(wind)!)) + " m/s"
                
            }

                
                            let clouds = data[15].split(separator: ":")[2].split(separator: "}")[0]
                //            print(clouds)
                            DispatchQueue.main.async {
                                            self.cloud_lbl.text =  "Chance of rain: " + String(Int((Float(clouds)!))*100) + "%"
                                        }
                            
                            let city = data[25].split(separator: ":")[1].split(separator:"\"")[0]
                //                  print(city)
                                  DispatchQueue.main.async {
                                    self.city_lbl.text = String(city)
                                              }

                
                
                                        }
//            }
   
    //        self.wind_lbl.text = String(wind)


//            print("-----------done-------")
  
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
