//
//  ValidationManager.swift
//  Kashihon
//
//  Created by t&a on 2023/07/15.
//

import UIKit

class ValidationManager {
    public func validationUrl(_ urlStr: String) -> Bool {
        guard let encurl = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return false
        }
        if let url = NSURL(string: encurl) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
}
