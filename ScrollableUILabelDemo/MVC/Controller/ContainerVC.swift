//
//  ContainerVideoVC.swift
//  VideoDiaryApp
//
//  Created by on 08/09/18.
//  Copyright © 2018 MM. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController {

    //MARK:- Variables
    var vc : UIViewController!
    var segueIdentifier : String!
    var lastViewController: UIViewController!
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

//        segueIdentifierReceivedFromParent(segueIdentifier: Constants.stickersSegue)
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:-
    func segueIdentifierReceivedFromParent(segueIdentifier identifier: String){
        segueIdentifier = identifier
        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            //Avoids creation of a stack of view controllers
            if lastViewController != nil {
                lastViewController.view.removeFromSuperview()
            }
            //Adds View Controller to Container "first" or "second"
            vc = segue.destination
            addChild(vc)
            vc.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            lastViewController = vc
        }
    }
    
    deinit {
        print("Container")
        vc = nil
        lastViewController = nil
        print("Finish Container")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
