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
    var localised: String { NSLocalizedString(self, comment: "") }
}
