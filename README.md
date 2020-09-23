# 3DCarouselView
Creating 3D CarouselView with the help of CALayer and CATransformLayer

## How to use
Drag and drop '3DCarouselView' folder in your app folder.
Open your view controller where you want to add Carousel paste following. Note that we have to suuply an array of UIImage.

    var  threeDCarouselView: ThreeDCarouselView! = nil
    //MARK:- View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        //1. Add CarouselView
        self.addCarousel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    //MARK:- Add CarouselView
    fileprivate func addCarousel() {
        self.threeDCarouselView = ThreeDCarouselView(controller: self, images: (1...6).map{UIImage(named: "m\($0)")!})
        self.threeDCarouselView.applyThreeDCarousel()
    }
    


## App in Action
![CarousalView](https://user-images.githubusercontent.com/2304583/94064175-952a3500-fde9-11ea-8ca3-cfc424027d06.gif)
