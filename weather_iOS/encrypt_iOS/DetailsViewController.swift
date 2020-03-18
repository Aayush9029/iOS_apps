//
//  DetailsViewController.swift
//  encrypt_iOS
//
//  Created by Aayush Pokharel on 2020-03-18.
//  Copyright © 2020 Aayush Pokharel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // Refrencing Story board elements
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    // Custom variables
    var sunriseVar: String = ""
    var sunsetVar: String = ""
    var visVar: String = ""
    var latVar: String = ""
    var lonVar: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        sunriseLabel.text  = "Sunrise: \(sunriseVar)"
        sunsetLabel.text  = "Sunset: \(sunsetVar)"
        visibilityLabel.text  = "Visibility: \(visVar) km"
        latLabel.text  = "Lat: \(latVar)"
        lonLabel.text  = "Lon: \(lonVar)"

    }
    


}
