//
//  MasterViewController.swift
//  HeaderScroll
//
//  Created by Michael Nachbaur on 4/13/20.
//  Copyright © 2020 Michael Nachbaur. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    var headerView: HeaderView = {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! HeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerView.titleLabel.text = "The title of the header"
        headerView.scrollView = tableView
        headerView.frame = CGRect(
            x: 0,
            y: tableView.safeAreaInsets.top,
            width: view.frame.width,
            height: 250)

        tableView.backgroundView = UIView()
        tableView.backgroundView?.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(
            top: 250,
            left: 0,
            bottom: 0,
            right: 0)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        tableView.contentInset = UIEdgeInsets(top: 250 + tableView.safeAreaInsets.top,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
        headerView.updatePosition()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerView.updatePosition()
    }
    
    // MARK: - UIScrollViewDelegate methods

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.updatePosition()
    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
}

