//
//  DeeplinkManager.swift
//  DeeplinkTest
//
//  Created by oslover on 12/4/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

let notification_name_app_opened = "APP_OPENED_BY_URL"

class DeeplinkManager {
    static let shared = DeeplinkManager()
    var url: URL? {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notification_name_app_opened), object: url)
        }
    }
}
