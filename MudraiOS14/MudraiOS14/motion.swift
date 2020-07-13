//
//  motion.swift
//  GyroData
//
//  Created by Aayush Pokharel on 2020-07-01.
//  Copyright © 2020 Aayush Pokharel. All rights reserved.
//


import Combine
import SwiftUI
import CoreMotion



class AltimatorManager: NSObject, ObservableObject {
    let willChange = PassthroughSubject<Void, Never>()
    
    var altimeter:CMAltimeter?
    
    @Published var pressureString:String = ""
    @Published var altitudeString:String = ""
    
    override init() {
        super.init()
        altimeter = CMAltimeter()
        startUpdate()
    }
    
    func doReset(){
        altimeter?.stopRelativeAltitudeUpdates()
        startUpdate()
    }
    
    
    func proximityChanged(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            print("\(device) detected!")
        }
    }
    
    func startUpdate() {
        if(CMAltimeter.isRelativeAltitudeAvailable()) {
            altimeter!.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler:
                                                        {data, error in
                                                            if error == nil {
                                                                let pressure:Double = data!.pressure.doubleValue
                                                                let altitude:Double = data!.relativeAltitude.doubleValue
                                                                self.pressureString = String(format: "Pressure:%.1f hPa", pressure * 10)
                                                                self.altitudeString = String(format: "Altitude:%.2f m",altitude)
                                                                self.willChange.send()
                                                            }
                                                        })
        }
    }
    
}
