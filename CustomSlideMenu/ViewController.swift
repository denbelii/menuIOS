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
    var menuObj: Menu?
    override func viewDidLoad() {
        super.viewDidLoad()
        menuObj = Menu(isShowingMenu: false, nameMainViewController: "Main", view: view)
        menuObj?.menuViewController.delegate = self
        menuObj?.startMenu(parentVC: self)
        menuObj?.toogleMenu()
    }
    
    
    @IBAction func menuButtonDidTouch(_ sender: Any) {
        menuObj?.toogleMenu()
    }
    
    func menuCloseButtonTapped() {
        menuObj?.toogleMenu()
        
    }
    
    func tapGestureRecognizer(){
        menuObj?.toogleMenu()
    }
}

