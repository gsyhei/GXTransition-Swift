//
//  OneViewController.swift
//  GXTransitionSample
//
//  Created by Gin on 2020/11/19.
//

import UIKit

class OneViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NSLog("viewDidDisappear")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "🔙", style: .plain, target: self, action: #selector(backBarButtonItemTapped))
        NSLog("viewDidLoad")
    }
    
    @objc func backBarButtonItemTapped() {
        if (self.navigationController?.popViewController(animated: true) == nil) {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func nextButtonClicked(_ sender: UIButton) {
        let vc = TwoViewController(nibName: "TwoViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
