//
//  VideoEditVC.swift
//  ScrollableUILabelDemo
//
//  Created by on 21/12/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit

class ScrollingLabelVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: Variables
    var arrLabels: [UILabel] = []
    private var container: ContainerVC!
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container"{
            print("Container View Initialized")
            container = segue.destination as? ContainerVC
        }
    }
    
    //MARK:- Class Methods
    private func initialize() {
        //Add the number of labels
        
        for label in self.viewMain.subviews {
            if label is UILabel {
                let lbl = label as! UILabel
                arrLabels.append(lbl)
            }
        }
        
        if arrLabels.count > 0 {
            containerView.isHidden = false
            container.segueIdentifierReceivedFromParent(segueIdentifier: "timelineView")
        }
    }
   
}
