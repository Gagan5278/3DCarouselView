//
//  Helper.swift
//  3DCarousel
//
//  Created by Gagan  Vishal on 9/23/20.
//

import Foundation
import UIKit
class Helper {
    //MARK:- Convert Degree into Radians
    class func convertDegreeToRadians(from degree: CGFloat) -> CGFloat {
        return (degree * CGFloat.pi)/180.0
    }
}
