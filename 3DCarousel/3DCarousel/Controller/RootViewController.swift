//
//  ViewController.swift
//  3DCarousel
//
//  Created by Gagan  Vishal on 9/23/20.
//

import UIKit

class RootViewController: UIViewController {
    
    var  threeDCarouselView: ThreeDCarouselView! = nil
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        self.addCarousel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK:-
    fileprivate func addCarousel() {
        self.threeDCarouselView = ThreeDCarouselView(controller: self, images: (1...6).map{UIImage(named: "m\($0)")!})
        self.threeDCarouselView.applyThreeDCarousel()
    }
    

}


