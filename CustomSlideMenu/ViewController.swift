//
//  ViewController.swift
//  CustomSlideMenu
//
//  Created by Андрей on 18.02.17.
//  Copyright © 2017 Андрей. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MenuViewControllerDelegate {
    
    var blackMaskView = UIView(frame: .zero)
    let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    var menuLeftConstraint: NSLayoutConstraint?
    var isShowingMenu = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add menu view controller
        addChildViewController(menuViewController)
        menuViewController.delegate = self
        menuViewController.didMove(toParentViewController: self)
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuViewController.view)
        
        let topConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 260)
        menuLeftConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: -widthConstraint.constant)
        
        view.addConstraints([topConstraint, bottomConstraint, widthConstraint, menuLeftConstraint!])
        toogleMenu()
    }
    
    func toogleMenu(){
        isShowingMenu = !isShowingMenu
        if  isShowingMenu {
            //HideMenu
            UIApplication.shared.isStatusBarHidden = false
            menuLeftConstraint?.constant = -menuViewController.view.bounds.size.width
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                self.menuViewController.view.isHidden = true
            })
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                self.blackMaskView.alpha = 0.0
            }, completion: { (completed) in
                self.blackMaskView.removeFromSuperview()
            })
        }else{
            //PresentMenu
            UIApplication.shared.isStatusBarHidden = true
            blackMaskView = UIView(frame: .zero)
            blackMaskView.alpha = 0
            blackMaskView.translatesAutoresizingMaskIntoConstraints = false
            blackMaskView.backgroundColor = .black
            view.insertSubview(blackMaskView, belowSubview: menuViewController.view)
            let topConstraint = NSLayoutConstraint(item: blackMaskView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: blackMaskView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            let leftConstraint = NSLayoutConstraint(item: blackMaskView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            let rightConstraint = NSLayoutConstraint(item: blackMaskView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            view.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { 
                
                self.blackMaskView.alpha = 0.5
            }, completion: { (completed) in
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGestureRecognizer))
                self.blackMaskView.addGestureRecognizer(tapGesture)
            })
            
            menuViewController.view.isHidden = false
            menuLeftConstraint?.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                
            })
        }
    }
    
    @IBAction func menuButtonDidTouch(_ sender: Any) {
        toogleMenu()
    }
    
    func menuCloseButtonTapped() {
        toogleMenu()
        
    }
    
    func tapGestureRecognizer(){
        toogleMenu()
    }
}

