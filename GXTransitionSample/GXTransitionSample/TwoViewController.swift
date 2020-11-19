//
//  TwoViewController.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/11/19.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "🔙", style: .plain, target: self, action: #selector(backBarButtonItemTapped))
    }
    
    @objc func backBarButtonItemTapped() {
        if (self.navigationController?.popViewController(animated: true) == nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
