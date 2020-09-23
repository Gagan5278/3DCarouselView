//
//  ExpandedImageView.swift
//  3DCarousel
//
//  Created by Gagan  Vishal on 9/23/20.
//

import Foundation
import UIKit

protocol CloseButtonAction: NSObject {
    func closeButtonPressed()
}

class ExpandedImageView: UIView {
    weak var delegate: CloseButtonAction?
    ///button to close  when full screen image available
    fileprivate lazy var closeViewButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: .normal)
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        closeButton.addTarget(self, action: #selector(self.hideFullscreen), for: .touchUpInside)
        return closeButton
    }()

    let fullImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(with image: UIImage) {
        super.init(frame: .zero)
        self.createFullscreenPhoto(image: image)
        self.setupCloseButton()
    }
    
    //MARK:- Create a full screen photo
    fileprivate func createFullscreenPhoto(image: UIImage)  {
        //1. set image to imageview
        self.fullImageView.image = image
        self.addSubview(fullImageView)
        //apply constraints
          NSLayoutConstraint.activate([
            self.fullImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.fullImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.fullImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.fullImageView.heightAnchor.constraint(equalTo: self.heightAnchor)
          ])
    }
    
    
    //MARK:- label achhor setup
    fileprivate func setupCloseButton() {
        self.addSubview(self.closeViewButton)
        NSLayoutConstraint.activate([
            closeViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            closeViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            closeViewButton.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            closeViewButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    //MARK:- Hide full screen image
    @objc func hideFullscreen() {
        self.delegate?.closeButtonPressed()
    }
}
