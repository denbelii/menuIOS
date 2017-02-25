//
//  TableViewController.swift
//  CustomSlideMenu
//
//  Created by Андрей on 19.02.17.
//  Copyright © 2017 Андрей. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, MenuViewControllerDelegate, UIGestureRecognizerDelegate{
    
    var menuObj: Menu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeForMenu(_:)))
        view.addGestureRecognizer(swipeGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGo(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func panGo(_ panG: UIPanGestureRecognizer){
        
        let coordinate = panG.location(in: view)
        switch panG.state {
        case .began:
            startMenu()
            print("Begin")
            menuObj?.dragMenu(tapPoint: coordinate)
            print("translation.x = \(coordinate.x), translation.y = \(coordinate.y)")
        case .changed:
            print("Changed")
            menuObj?.dragMenu(tapPoint: coordinate)
            print("translation.x = \(coordinate.x), translation.y = \(coordinate.y)")
        case .cancelled:
            
            print(":))")
            print("translation.x = \(coordinate.x), translation.y = \(coordinate.y)")
        case .ended:
        menuObj?.endPan()
            
        default:
            print("DEFAULT")
        }
        
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
        case .cancelled:
            print("cancelled))")
            print("translation.x = \(coordinate.x), translation.y = \(coordinate.y)")
        default:
            print(":))")
            print("translation.x = \(coordinate.x), translation.y = \(coordinate.y)")
        }
        
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "News"
            
        case 1:
            cell.textLabel?.text = "App"
        case 2:
            cell.textLabel?.text = "Author"
            
        default:
            cell.textLabel?.text = "UPS!"
        }
        
        return cell
    }
    
    func startMenu(){
        if menuObj == nil{
            menuObj = Menu(isShowingMenu: false, view: view)
            menuObj?.menuViewController.delegate = self
            menuObj?.startMenu(parentVC: self)
        }
    }
    
    @IBAction func tapDidMenu(_ sender: Any) {
        print("menuOk")
        startMenu()
        menuObj?.toogleMenu()
    }
    
    func menuCloseButtonTapped() {
        menuObj?.toogleMenu()
        
    }
    
}
