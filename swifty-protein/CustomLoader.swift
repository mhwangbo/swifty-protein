//
//  CustomLoader.swift
//  swifty-protein
//
//  Created by Kristine Sonu on 1/18/19.
//  Copyright © 2019 Kristine Sonu. All rights reserved.
//

import UIKit

class CustomLoader: UIView {
    static let instance = CustomLoader()
    
    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: UIScreen.main.bounds)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }()
    
    lazy var gifImage: UIImageView = {
        let gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        //gifImage.loadGif(name: "activityIndicator")
        return gifImage
    }()
    
    func showLoader() {
        self.addSubview(transparentView)
        self.transparentView.addSubview(gifImage)
        self.transparentView.bringSubviewToFront(self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparentView)
    }
    
    func hideLoader() {
        self.transparentView.removeFromSuperview()
    }
}
