//
//  Extension.swift
//  travel-interview
//
//  Created by ZHI on 2024/11/22.
//

import Foundation
import UIKit

public extension String {
    var image: UIImage { UIImage(named: self)! }
    var color: UIColor { UIColor(named: self)! }
    var localised: String {
        let languageCode = LanguageManager.instance.languageCode ?? "en"
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path)
        else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
    }
}

public extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}

public extension UIViewController {
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        return self.presentedViewController!.topMostViewController()
    }
}
