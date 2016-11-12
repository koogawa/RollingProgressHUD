//
//  ViewController.swift
//  RollingProgressHUD
//
//  Created by koogawa on 2016/11/12.
//  Copyright © 2016年 koogawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func show(_ sender: Any) {
        RollingProgressHUD.show()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            RollingProgressHUD.dismiss()
        }
    }
}

