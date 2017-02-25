//
//  ViewController.swift
//  CustomSlideMenu
//
//  Created by Андрей on 18.02.17.
//  Copyright © 2017 Андрей. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MenuViewControllerDelegate, UIGestureRecognizerDelegate {
    
    //var blackMaskView = UIView(frame: .zero)
    //let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    //var menuLeftConstraint: NSLayoutConstraint?
    //var isShowingMenu = false
    var menuObj: Menu?
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeForMenu(_:)))
        swipeGesture.direction = .right
        swipeGesture.delegate = self
        view.addGestureRecognizer(swipeGesture)

    }

    func swipeForMenu(_ swipe: UISwipeGestureRecognizer){
        //if swipe.direction == .right{
        print("Swipe.right")
        let coordinate = swipe.location(in: view)
        
        if swipe.state == .began{
            print("Begin")
        }
        
        if swipe.state == .changed{
            print("Changed")
        }
        
        switch swipe.state {
        case .began:
            print("Begin")
            print("translation.x = \(coordinate.x), translation.y = \(coordinate.y)")
        case .changed:
            print("Changed")
            print("translation.x = \(coordinate.x), translation.y = \(coordinate.y)")
        default:
            print(":))")
            print("translation.x = \(coordinate.x), translation.y = \(coordinate.y)")
        }
        
        //}
    }
    
    @IBAction func menuButtonDidTouch(_ sender: Any) {
        menuObj?.toogleMenu()
        if menuObj == nil{
            menuObj = Menu(isShowingMenu: false, view: view)
            menuObj?.menuViewController.delegate = self
            menuObj?.startMenu(parentVC: self)
        }
        menuObj?.toogleMenu()
    }
    
    func menuCloseButtonTapped() {
        menuObj?.toogleMenu()
        
    }

    


}

