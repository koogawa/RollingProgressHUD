//
//  RollingProgressHUD.swift
//  RollingProgressHUD
//
//  Created by koogawa on 2016/11/12.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import UIKit

open class RollingProgressHUD: UIView {

    private var degree: CGFloat = 0.0
    private var capturedView: UIImageView?
    private var overlayView: UIView?
    private var timer: Timer?
    static let sharedView = RollingProgressHUD()

    private init() {
        print(#function)
        super.init(frame: UIScreen.main.bounds)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func show() {
        RollingProgressHUD.sharedView.showOverlayView()
    }

    static func dismiss() {
        RollingProgressHUD.sharedView.dismissOverlayView()
    }

    private func showOverlayView() {
        guard self.overlayView == nil else { return }
        
        var frontWindow: UIWindow!

        for window in UIApplication.shared.windows.reversed() {
            if window.windowLevel == UIWindowLevelNormal &&
                !window.isHidden && window.alpha > 0 &&
                window.screen == UIScreen.main {
                frontWindow = window
                break
            }
        }

        guard frontWindow != nil else { return }

        UIGraphicsBeginImageContextWithOptions(frontWindow.bounds.size, false, UIScreen.main.scale)
        frontWindow.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.overlayView = UIView(frame: CGRect(origin: frontWindow.bounds.origin, size: frontWindow.bounds.size))
        self.overlayView?.backgroundColor = UIColor.black

        self.capturedView = UIImageView(frame: CGRect(origin: frontWindow.bounds.origin, size: frontWindow.bounds.size))
        self.capturedView?.image = image
        self.overlayView?.addSubview(self.capturedView!)

        if let overlayView = self.overlayView {
            frontWindow.addSubview(overlayView)
            self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector:#selector(RollingProgressHUD.roll), userInfo: nil, repeats: true)
        }
    }

    private func dismissOverlayView() {
        self.timer?.invalidate()
        self.overlayView?.removeFromSuperview()
        self.overlayView = nil
        self.capturedView = nil
    }

    @objc private func roll() {
        self.degree += 10.0
        self.capturedView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI) * degree / 180.0)
    }
}
