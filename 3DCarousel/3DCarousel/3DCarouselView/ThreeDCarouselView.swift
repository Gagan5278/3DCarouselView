//
//  3DCarouselView.swift
//  3DCarousel
//
//  Created by Gagan  Vishal on 9/23/20.
//

import Foundation
import UIKit
class ThreeDCarouselView: NSObject {
    //UIViewController to display CarouselView
    var viewController: UIViewController
    //image array
    fileprivate var arrayOfImages: [UIImage]
    fileprivate var transaformLayer = CATransformLayer()
    fileprivate var currentAngle: CGFloat = 0.0
    fileprivate var curentOffset: CGFloat = 0.0
    fileprivate var defualtMatrix: Matrix = .m34
    //view to hold full screen image
    var fullscreenView: ExpandedImageView! = nil
    //Pan Gesture
    fileprivate lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ThreeDCarouselView.panGesture(recogniser:)))
        self.viewController.view.isUserInteractionEnabled = true
        return panGesture
    }()
    //Tap Gesture
    fileprivate lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let panGesture = UITapGestureRecognizer(target: self, action: #selector(ThreeDCarouselView.tapGesture(recogniser:)))
        self.viewController.view.isUserInteractionEnabled = true
        return panGesture
    }()
    
    //Border color
    var imageBorderColor: UIColor {
        return UIColor(white: 0.8, alpha: 0.9)
    }
    
    //Border width
    var imageBorderWidth: CGFloat {
        return 5.0
    }
    
    //Image Corner Radius
    var imageCornerRadius: CGFloat {
        return 12.0
    }
    
    //MARK:- Init
    init(controller: UIViewController, images: [UIImage]) {
        //1.
        self.arrayOfImages = images
        self.viewController = controller
    }
    
    //MARK:- Add pan gesture
    fileprivate func addPanGesture(){
        //1.Tap
        self.viewController.view.addGestureRecognizer(self.tapGestureRecognizer)
        //2. Pan
        self.viewController.view.addGestureRecognizer(self.panGestureRecognizer)
    }
    
    //MARK:- Apply 3D Carousel
    func applyThreeDCarousel(_ matrix: Matrix = .m34)  {
        self.defualtMatrix = matrix
        self.transaformLayer.frame = self.viewController.view.bounds
        self.viewController.view.layer.addSublayer(self.transaformLayer)
        //1. Add images        
        for image in self.arrayOfImages {
            addImage(image: image)
        }
        //2.
        self.apply3DLayering()
        //3.
        self.addPanGesture()
    }
    
    //MARK:- Add Image on layer
    fileprivate func addImage(image: UIImage) {
        //1.
        let sizeOfView  = self.viewController.view.frame.size
        let imageSize = CGSize(width: 200, height: 300)
        //2.
        let layer = CALayer()
        layer.frame = CGRect(x: sizeOfView.width/2 - imageSize.width/2 , y: sizeOfView.height/2 - imageSize.height/2, width: imageSize.width, height: imageSize.height)
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.backgroundColor = UIColor.red.cgColor
        //3. add on layer and apply moification
        layer.contents = image.cgImage
        layer.contentsGravity = .resizeAspectFill
        layer.masksToBounds = true
        layer.isDoubleSided = true
        //4.
        layer.borderWidth = 5.0
        layer.cornerRadius = 12.0
        layer.borderColor = UIColor(white: 0.8, alpha: 0.9).cgColor
        //5.
        self.transaformLayer.addSublayer(layer)
    }
    
    //MARK:- Apply 3D Layering
    fileprivate func apply3DLayering() {
        //check for subllayers. If not available then return immediately
        guard let allLayers = self.transaformLayer.sublayers else { return }
        //store current angle
        var angelOffset = self.currentAngle
        //get all segments
        let allCardSegments = CGFloat(360/allLayers.count)
        //run a loop on available sublayrs
        for layer in allLayers {
            //1.
            var transform3DIdentity = CATransform3DIdentity
            //2. Access 3rd row and 4th Column in 4x4 matrix.Make it poitive and have some fun :D
            switch defualtMatrix {
            case .m12:
                transform3DIdentity.m12 = -1/1000
            case .m13:
            transform3DIdentity.m13 = -1/1000
            case .m14:
                transform3DIdentity.m14 = -1/1000
            case .m21:
                transform3DIdentity.m21 = -1/1000
            case .m23:
                transform3DIdentity.m23 = -1/1000
            case .m24:
            transform3DIdentity.m24 = -1/1000
            case .m31:
            transform3DIdentity.m31 = -1/1000
            case .m32:
            transform3DIdentity.m32 = -1/1000
            case .m34:
                transform3DIdentity.m34 = -1/1000
            case .m41:
            transform3DIdentity.m41 = -1/1000
            case .m42:
                transform3DIdentity.m42 = -1/1000
            case .m43:
                transform3DIdentity.m43 = -1/1000
            }
            //3.
            transform3DIdentity = CATransform3DRotate(transform3DIdentity, Helper.convertDegreeToRadians(from: angelOffset), 0, 1, 0)
            transform3DIdentity = CATransform3DTranslate(transform3DIdentity, 0, 0, 200)
            //4. Disable auto animation
            CATransaction.setAnimationDuration(0.0)
            //5. Apply Transform identity to layer
            layer.transform = transform3DIdentity
            //6. Set angle
            angelOffset += allCardSegments
        }
    }
    
    //MARK:- Pan Gesture
    @objc fileprivate func tapGesture(recogniser: UIPanGestureRecognizer) {
        let location = recogniser.location(in: self.viewController.view)
        let point = self.viewController.view.convert(location, from: nil)

         let foundLayer = self.transaformLayer.hitTest(point)

        if let shapeLayer = foundLayer, let cgImage = shapeLayer.contents  {
            self.showFullScreen(for: UIImage(cgImage: (cgImage as! CGImage)))
         }
        
    }
    
    //MARK:- Pan Gesture
    @objc fileprivate func panGesture(recogniser: UIPanGestureRecognizer) {
        if recogniser.state == .began {
            self.curentOffset = 0
        }
        //1.
        let xOffset =  recogniser.translation(in: self.viewController.view).x
        //2. Get Diff and slow down sspeed with 0.5 fraction
        let diffXOffset = xOffset*0.5 - self.curentOffset
        //3. Update offset and angle
        self.curentOffset += diffXOffset
        self.currentAngle += diffXOffset
        //On end place image in center
        if defualtMatrix == .m34 {
            if recogniser.state == .ended {
                UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseIn) {
                    let angled = 360/self.arrayOfImages.count
                    let findAngled = CGFloat(self.closestAngle(a: Int(self.currentAngle), b: angled))
                    self.currentAngle = findAngled
                } completion: { (_) in
                    self.apply3DLayering()
                }
            }
        }

        //4. Recall Translate
        self.apply3DLayering()
    }
    
    //MARK:- Get closest angel. Copied from Stackoverflow
    fileprivate func closestAngle( a : Int,  b: Int) -> Int {
        let c1 = a - (a%b);
        let c2 = (a + b) - (a%b);
        if (a - c1 > c2 - a) {
            return c2;
        } else {
            return c1;
        }
    }
    
    //MARK:- Show image on full screen
    fileprivate func showFullScreen(for image: UIImage) {
        //1. Create full sceen object
        self.fullscreenView = ExpandedImageView(with: image)
        self.fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        self.viewController.view.addSubview(fullscreenView)
        //
        self.fullscreenView.delegate = self
        //2. Apply constraints
        NSLayoutConstraint.activate([
            self.fullscreenView.leadingAnchor.constraint(equalTo: self.viewController.view.leadingAnchor),
            self.fullscreenView.trailingAnchor.constraint(equalTo: self.viewController.view.trailingAnchor),
            self.fullscreenView.topAnchor.constraint(equalTo: self.viewController.view.topAnchor),
            self.fullscreenView.heightAnchor.constraint(equalTo: self.viewController.view.heightAnchor)
        ])
        fullscreenView.sprinhShowAnimation()
        //3. Hide CATrasformLayer
        transaformLayer.isHidden = true
    }

    //MARK:- Enum to handle different design
    
    enum Matrix {
        case m12
        case m13
        case m14
        case m21
        case m23
        case m24
        case m31
        case m32
        case m34
        case m41
        case m42
        case m43
    }
}

//MARK:- CloseButtonAction
extension ThreeDCarouselView: CloseButtonAction {
    func closeButtonPressed() {
        if let _ = self.fullscreenView {
            self.fullscreenView .hideAnimation()
            self.fullscreenView .removeFromSuperview()
        }
        self.transaformLayer.isHidden = false
    }
}
