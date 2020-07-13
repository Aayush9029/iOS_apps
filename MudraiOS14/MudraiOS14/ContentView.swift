//
//  ContentView.swift
//  MudraiOS14
//
//  Created by Aayush Pokharel on 2020-07-13.
//


import SwiftUI
import CoreMotion



struct ContentView: View {
    let altimeter = CMAltimeter()
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State private var pitch = Double.zero
    @State private var yaw = Double.zero
    @State private var roll = Double.zero
    
    @State private var magX = Double.zero
    @State private var magY = Double.zero
    @State private var magZ = Double.zero
    
    @ObservedObject var manager = AltimatorManager()
    let availabe = CMAltimeter.isRelativeAltitudeAvailable()
    
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                List{
                    
                    
                    
                    Text("Pitch (lift Up): \(pitch)")
                    Text("Yaw (point Side): \(yaw)")
                    Text("Roll (rotate sideways): \(roll)")
                    
                    Text("Magnetometer Data X: \(magX)")
                    Text("Magnetometer Data Y: \(magY)")
                    Text("Magnetometer Data Z: \(magZ)")
                    
                    Text(availabe ? manager.pressureString : "Pressure: _ _ _ _ ")
                    Text(availabe ? manager.altitudeString : "Attitude: _ _ _ _")
                    
                    Button("Notification Check: Read Info", action: {
                        NotifNamager().scheduleNotification()
                        
                    })
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color(.systemPink))
                    .cornerRadius(5)
             
                    
                }.onAppear {
                    self.motionManager.startDeviceMotionUpdates(to: self.queue) { (data: CMDeviceMotion?, error: Error?) in
                        guard let data = data else {
                            print("Error: \(error!)")
                            return
                        }
                        let attitude: CMAttitude = data.attitude
                        
                        DispatchQueue.main.async {
                            self.pitch = attitude.pitch
                            self.yaw = attitude.yaw
                            self.roll = attitude.roll
                        }
                    }
                    self.motionManager.startMagnetometerUpdates(to: self.queue) { (data: CMMagnetometerData?, error:Error?) in
                        guard let data = data else {
                            print("Error: \(error!)")
                            return
                        }
                        let magData: CMMagneticField = data.magneticField
                        
                        DispatchQueue.main.async {
                            self.magX = magData.x
                            self.magY = magData.y
                            self.magZ = magData.z
                            
                        }
                    }
                    
                }
                NavigationLink(destination: DetailedInfo()){
                    Text("Info").padding()
                }
            }
            .navigationBarTitle(Text("iPhone Sensor API"))
            
        }
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

