//
//  HelloVC.swift
//  DemoUIPageViewController
//
//  Created by Apple on 4/27/20.
//  Copyright © 2020 vinova. All rights reserved.
//

import UIKit

class HelloVC: UIViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapPushBtn(_ sender: Any) {
        print("12")
//        let nib = WorldVC(nibName: "WorldVC", bundle: nil)
//        self.navigationController?.pushViewController(nib, animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}