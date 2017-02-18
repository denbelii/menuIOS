//
//  MenuViewController.swift
//  CustomSlideMenu
//
//  Created by Андрей on 18.02.17.
//  Copyright © 2017 Андрей. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
   func menuCloseButtonTapped()
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var delegate: MenuViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
   
    @IBAction func menuClosedDidTouch(_ sender: Any) {
        delegate?.menuCloseButtonTapped()
    }
}
