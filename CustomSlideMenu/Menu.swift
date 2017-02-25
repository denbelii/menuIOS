//
//  Menu.swift
//  CustomSlideMenu
//
//  Created by Андрей on 18.02.17.
//  Copyright © 2017 Андрей. All rights reserved.
//

import Foundation
import UIKit

class Menu{
    
    let nameMainStoryboard = "Main"
    var isShowingMenu = false
    var blackMaskView = UIView(frame: .zero)
    let menuViewController: MenuViewController
    let view: UIView
    var menuLeftConstraint: NSLayoutConstraint?
    var deltaYMenu: CGFloat?
    
    init(isShowingMenu: Bool, view: UIView) {
        self.isShowingMenu = isShowingMenu
        self.menuViewController = UIStoryboard(name: nameMainStoryboard, bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        self.view = view
    }
    
    func startMenu (parentVC: UIViewController){
        parentVC.addChildViewController(menuViewController)
        menuViewController.didMove(toParentViewController: parentVC)
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuViewController.view)
        let topConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 260)
        menuLeftConstraint = NSLayoutConstraint(item: menuViewController.view, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: -widthConstraint.constant)
        view.addConstraints([topConstraint, heightConstraint, widthConstraint, menuLeftConstraint!])
    }
    
    func toogleMenu(){
        if menuViewController.delegate != nil{
            if let menuLeftConstraint = menuLeftConstraint{
                isShowingMenu = !isShowingMenu
                if  !isShowingMenu {
                    //HideMenu
                    UIApplication.shared.isStatusBarHidden = false
                    menuLeftConstraint.constant = -(menuViewController.view.bounds.size.width)
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
                    let heightConstraint = NSLayoutConstraint(item: blackMaskView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
                    let leftConstraint = NSLayoutConstraint(item: blackMaskView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
                    let widthConstraint = NSLayoutConstraint(item: blackMaskView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
                    view.addConstraints([topConstraint, heightConstraint, leftConstraint, widthConstraint])
                    self.view.layoutIfNeeded()
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                        self.blackMaskView.alpha = 0.5
                    }, completion: { (completed) in
                        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureRecognizer))
                        self.blackMaskView.addGestureRecognizer(tapGesture)
                    })
                    menuViewController.view.isHidden = false
                    menuLeftConstraint.constant = 0
                    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: { (completed) in
                    })
                    
                }
            }else{
                print("Error Need Call Func Start")
            }
        }else{
            print("Error Need Set delegate mainViewController")
        }
    }
    
    func dragMenu(tapPoint: CGPoint){
        
        if tapPoint.x >= 0{
            var deltaReal: CGFloat = 0
            if let deltaYMenu = deltaYMenu{
                deltaReal  = deltaYMenu == 0 ? 0 : tapPoint.x - deltaYMenu
               print("deltaReal = \(deltaReal)")
            }
            
            //let x = (self.menuViewController.view.center.x + deltaReal) - self.menuViewController.view.frame.size.width
            
            let halfWidth = menuViewController.view.bounds.size.width / 2
            var newXCenter = self.menuViewController.view.center.x + deltaReal
            let x = newXCenter - halfWidth
            newXCenter = x > 0 ? halfWidth : x
            //print("x = \(x)")
            if x <= 0 && x >= -menuViewController.view.bounds.size.width{
                //let centerX = tapPoint.x + (menuViewController.view.bounds.size.width / 2)
            
                UIView.animate(withDuration: 0.2, animations: {
                    self.menuViewController.view.center = CGPoint(x: self.menuViewController.view.center.x + deltaReal, y: self.menuViewController.view.center.y)
                })}
            }
        
        //print("menuViewController.view.frame.origin.x = \(menuViewController.view.frame.origin.x)")
        deltaYMenu = tapPoint.x
    }
    
    
    
    func endPan(){
        deltaYMenu = 0
        print("CCAANN")
    }
    
    @objc func tapGestureRecognizer(){
        toogleMenu()
    }
}
