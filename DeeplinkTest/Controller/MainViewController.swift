//
//  MainViewController.swift
//  DeeplinkTest
//
//  Created by oslover on 12/4/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnCapture: CaptureButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateStatusLabel()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notification_name_app_opened), object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
                self.updateStatusLabel()
            }
        }
    }
    
    func updateStatusLabel() {
        if let url = DeeplinkManager.shared.url {
            if let params = url.queryParameters {
                lblStatus.text = "\(params)"
            }
        }
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        btnCapture.isPhotoButton = sender.isOn
    }
}
