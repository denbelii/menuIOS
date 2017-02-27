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
    var isRightFirstTap = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGo(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func panGo(_ panG: UIPanGestureRecognizer){
        let coordinate = panG.location(in: view)
        switch panG.state {
        case .began: break
        case .changed:
            let velocity = panG.velocity(in: view)
            if velocity.x > 0 || isRightFirstTap{
                startMenu()
                menuObj?.dragMenu(tapPoint: coordinate)
            }
        case .ended:
            menuObj?.endPan(velocity: panG.velocity(in: view).x)
        default:
            print("DEFAULT")
        }
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
            isRightFirstTap = true
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
