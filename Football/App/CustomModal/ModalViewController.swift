//
//  ModalViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class ModalViewController: UIViewController {
    static let vcLoading = ModalViewController(nibName: "ModalViewController", bundle: nil)
    @IBOutlet weak var icLoading: UIImageView!
    @IBOutlet weak var modalContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        modalContainer.layer.cornerRadius = 16
        icLoading.rotate360()
        setBackgroundOverlay(view: self.view)
        // Do any additional setup after loading the view.
    }
    
    func showLoading() {
        guard let rootVC = self.topViewController() else { return }
        ModalViewController.vcLoading.view.layoutIfNeeded()
        ModalViewController.vcLoading.willMove(toParent: rootVC)
        rootVC.addChild(ModalViewController.vcLoading)
        rootVC.view.addSubview(ModalViewController.vcLoading.view)
        ModalViewController.vcLoading.view.frame = rootVC.view.frame
        ModalViewController.vcLoading.didMove(toParent: rootVC)
    }
    
    func hideLoading() {
        ModalViewController.vcLoading.view.removeFromSuperview()
        ModalViewController.vcLoading.willMove(toParent: nil)
        ModalViewController.vcLoading.removeFromParent()
        ModalViewController.vcLoading.didMove(toParent: nil)
        
    }
    
    func topViewController(controller : UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    func setBackgroundOverlay(view : UIView) {
        view.backgroundColor = UIColor.white
//        view.frame = CGRect(x: 0 , y: 0, width: 200, height: 200)

    }
    
}

extension UIView {
    func rotate360(duration : CFTimeInterval = 1) {
        let rotateAnimation = CABasicAnimation(keyPath: "tranform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}



