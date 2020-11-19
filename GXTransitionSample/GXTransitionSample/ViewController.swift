//
//  ViewController.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/11/18.
//

import UIKit

let GX_ANIMATION_SUBTYPE = ["top", "left", "right", "bottom"]

let GX_ANIMATION_CUSTOM  = ["Push"]

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var subtype: GXAnimationSubtype = .left
    var rectEdges: UIRectEdge = .left
        
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "GXTransition"
        self.tableView.rowHeight = 50.0
        self.tableView.sectionHeaderHeight = 0.0
        self.tableView.sectionFooterHeight = 0.0
        
        self.tableView.estimatedRowHeight = 0.0
        self.tableView.estimatedSectionHeaderHeight = 0.0
        self.tableView.estimatedSectionFooterHeight = 0.0
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50.0, right: 0)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GX_ANIMATION_CUSTOM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellID: String = "CellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: CellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellID)
        }
        cell?.textLabel?.text = GX_ANIMATION_CUSTOM[indexPath.row]
        
        return cell!
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = OneViewController(nibName: "OneViewController", bundle: nil)
        let navc = UINavigationController(rootViewController: vc)
        switch indexPath.row {
        case 0:
            self.gx_present(navc, style: .push, subtype: self.subtype, rectEdges: self.rectEdges)
            
        default: break
        }
    }
    
}



extension ViewController {
    
    @IBAction func edgesChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.rectEdges = .left
        case 1:
            self.rectEdges = .right
        default: break
        }
    }
    
    @IBAction func subtypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.subtype = .top
        case 1:
            self.subtype = .left
        case 2:
            self.subtype = .right
        case 3:
            self.subtype = .bottom
        default: break
        }
    }
}
