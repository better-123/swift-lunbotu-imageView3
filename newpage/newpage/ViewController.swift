//
//  ViewController.swift
//  newpage
//
//  Created by better on 2020/2/11.
//  Copyright © 2020 monstar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let fenye = FenYeView(frame: CGRect(x: 7, y: 40, width: 400, height: 200))
//        fenye.imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg"]
        
        let fenye = FenYeView(frame: CGRect(x: 7, y: 40, width: 400, height: 200), imageArr: ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg"])
        
        view.addSubview(fenye)
        
        
        
    }
    
}


