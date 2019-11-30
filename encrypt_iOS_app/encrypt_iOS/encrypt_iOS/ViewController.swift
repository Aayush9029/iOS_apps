//
//  ViewController.swift
//  encrypt_iOS
//
//  Created by Aayush Pokharel on 2019-11-29.
//  Copyright © 2019 Aayush Pokharel. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var formField: UITextField!
    
    @IBOutlet weak var lbl: UILabel!

    @IBAction func encode(_ sender: Any) {
        let tt = formField.text
        let base64Encoded = Data(tt!.utf8).base64EncodedString()
        print("encoding..",base64Encoded )
        UIPasteboard.general.string = base64Encoded
        lbl.text = "copied to clipboard..."
        formField.text = base64Encoded

    }
    
    @IBAction func decode(_ sender: Any) {
        let txt = formField.text;
        guard let decodedData = Data(base64Encoded: txt!) else { return }
       let decodedString = String(data: decodedData, encoding: .utf8)!
        UIPasteboard.general.string = decodedString
         lbl.text = "copied to clipboard..."
        formField.text = decodedString
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

