//
//  Extensions.swift
//  auGalybe
//
//  Created by Kristaps Grinbergs on 09/09/2019.
//  Copyright © 2019 fassko. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
  func openSafari(with link: String?) {
    guard let link = link,
      let url = URL(string: link) else {
        return
    }
    
    let safariViewController = SFSafariViewController(url: url)
    present(safariViewController, animated: true)
  }
  
  func open(_ url: String) {
    guard let url = URL(string: url) else {
      return
    }
    
    UIApplication.shared.open(url, options: [:])
    UIApplication.shared.isIdleTimerDisabled = true
  }
}

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: self)
  }
}

extension Locale {
  var currentLanguage: String {
    switch languageCode {
    case "en":
      return "en"
    case "lt":
      return "lt"
    default:
      return "en"
    }
  }
}
