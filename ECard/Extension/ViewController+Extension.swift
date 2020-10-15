//
//  ViewController+Extension.swift
//  ECard
//
//  Created by LinhNguyen on 10/15/20.
//  Copyright © 2020 LinhNguyen. All rights reserved.
//

import Foundation
import UIKit
import  NVActivityIndicatorView
extension UIViewController {
    func showIndicator() {
        show(in: self.view)
    }
    func hideIndicator() {
        hide(in: self.view)
    }
    // MARK: Animations
    func fadeInAnimation(view: UIView) {
           view.alpha = 0.0
             let size = CGSize(width: 60.0, height: 60.0)
         let cornerRadius: CGFloat = 8.0
        let backgroundColor: UIColor = UIColor(white: 1.0, alpha: 0.0)
         let containerBackgroundColor: UIColor = UIColor(white: 1.0, alpha: 0.0)

           let backgroundView = UIView(frame: CGRect(origin: .zero,
                                                     size: size))
        backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.75)
        backgroundView.layer.cornerRadius = cornerRadius
           backgroundView.center = view.center
           view.insertSubview(backgroundView, at: 0)

        UIView.animate(withDuration:0.5,
                          delay: 0.0,
                          options: [.curveEaseInOut, .beginFromCurrentState],
                          animations: {
                           view.alpha = 1.0
           }, completion: nil)
       }

    func fadeOutAnimation(view: UIView, complete: @escaping () -> Void) {
           view.alpha = 1.0
           UIView.animate(withDuration: AppConstants.animationInterval,
                          delay: 0.0,
                          options: [.curveEaseInOut, .beginFromCurrentState],
                          animations: {
                           view.alpha = 0.0
           }, completion: { completed in
               if completed {
                   complete()
               }
           })
       }
     func show(in mainView: UIView) {
           let containerView = UIView(frame: UIScreen.main.bounds)
            let containerBackgroundColor =  UIColor(white: 1.0, alpha: 0.0)
            let size = CGSize(width: 60.0, height: 60.0)

           containerView.backgroundColor = containerBackgroundColor
           containerView.restorationIdentifier = "restorationIdentifier"
           fadeInAnimation(view: containerView)

           let activityIndicatorView = NVActivityIndicatorView(
               frame: CGRect(origin: .zero, size: size),
               type: .ballRotateChase,
               color: .purple,
               padding: 10.0)

           activityIndicatorView.startAnimating()
           activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
           containerView.addSubview(activityIndicatorView)

           // Add constraints for `activityIndicatorView`.
           ({
               let xConstraint = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: activityIndicatorView, attribute: .centerX, multiplier: 1, constant: 0)
               let yConstraint = NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: activityIndicatorView, attribute: .centerY, multiplier: 1, constant: 0)

               containerView.addConstraints([xConstraint, yConstraint])
               }())

           let center = mainView.convert(containerView.center, from: nil)
           containerView.center = center
           mainView.addSubview(containerView)
       }

        func hide(in mainView: UIView) {
           for item in mainView.subviews
               where item.restorationIdentifier == "restorationIdentifier" {
                   fadeOutAnimation(view: item) {
                       item.removeFromSuperview()
                   }
           }
       }
}
