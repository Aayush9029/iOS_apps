//
//  ViewController.swift
//  NotifyMovement
//
//  Created by Aayush Pokharel on 2019-11-30.
//  Copyright © 2019 Aayush Pokharel. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

var player: AVAudioPlayer?

class ViewController: UIViewController {
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "rick", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    var move = 0
    var isArmed = false
    
    @IBOutlet weak var pin: UITextField!
    
    var motion = CMMotionManager()
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var x: UILabel!
    
    

    func checkMovement(m: Int){
        
        if m != 0{
            let alertController = UIAlertController(title: "Ahhh, phone moved", message:
                   "Hey put it down i'm calling the owner!", preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "Sorry :(", style: .default))

               self.present(alertController, animated: true, completion: nil)
            
            playSound()
            
        }
    }
    
    
    @IBAction func activate(_ sender: Any) {
        if pin.text == "929"{
//        print("activated", pin.text!)
            lbl.text = "armed"
            pin.text = ""
            isArmed = true
        }else{
            lbl.text = "wrong pin"
        }
    }
    
    @IBAction func deactivate(_ sender: Any) {
        if pin.text == "929"{
//        print("deactivated", pin.text!)
            lbl.text = "unarmed"
            pin.text = ""
            isArmed = false


        }else{
            lbl.text = "wrong pin"

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func myGyroscope(){
              print("Start Gyroscope")
              motion.gyroUpdateInterval = 0.1
              motion.startGyroUpdates(to: OperationQueue.current!) {
                  (data, error) in
                  if let trueData =  data {
                      self.view.reloadInputViews()
                    let m = Int(trueData.rotationRate.x)
                    if self.isArmed{
                        self.checkMovement(m:m)
                    }
//                      self.x!.text = "x: \(Int(trueData.rotationRate.x))"
                  }
              }
              return
          }
        
        myGyroscope()

    }


}

