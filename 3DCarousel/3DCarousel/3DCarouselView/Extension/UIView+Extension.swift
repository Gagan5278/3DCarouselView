//
//  UIView+Extension.swift
//  3DCarousel
//
//  Created by Gagan  Vishal on 9/23/20.
//

import Foundation
import UIKit

extension UIView {
    //MARK:- Preset sccreen with spring animation
    func sprinhShowAnimation() {
        transform =
            CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
        UIView.animate(withDuration: 0.3 / 1.5, animations: { [self] in
            transform =
                CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }) { finished in
            UIView.animate(withDuration: 0.3 / 2, animations: { [self] in
                transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }) { finished in
                UIView.animate(withDuration: 0.3 / 2, animations: { [self] in
                    transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    //MARK:- Hide animation
    func hideAnimation() {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.3) {[self] in
            self.alpha = 0.7
        } completion: { [self] finished in
            alpha = 0.0
        }

    }
}
