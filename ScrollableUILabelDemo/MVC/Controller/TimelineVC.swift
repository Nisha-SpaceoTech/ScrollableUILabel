//
//  TimelineVC.swift
//  ScrollableUILabelDemo
//
//  Created by on 21/12/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit
import AVKit

class TimelineVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Outlets
    @IBOutlet weak var tblScrolling: UITableView!
    @IBOutlet weak var viewPanGesture: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    //MARK: Variables
    var cellSize = 40
    var maxCellCount = 5
    var isMinimize = false
    var isChanged = false
    
    var textStickers = ["Label 1", "Label 2", "Label 3"]
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.handleGesture(gestureRecognizer:)))
        self.viewPanGesture.addGestureRecognizer(panGesture)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        var arrCount = isMinimize ? 1 : textStickers.count

        if arrCount > maxCellCount {
            arrCount = maxCellCount
        }
        var viewheight = CGFloat((cellSize * arrCount) + 90)
        if viewheight > 230 {
            viewheight = 230
        }
        self.heightConstraint.constant = viewheight
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
    }
    
    
    //MARK:-
    @objc func handleGesture(gestureRecognizer: UIPanGestureRecognizer)
    {
        let velocity: CGPoint =  gestureRecognizer.velocity(in: self.viewPanGesture)
        if isChanged
        {
            return;
        }
        
        if(velocity.y > 0)
        {
            // Down
            print("down")
            isMinimize = true
            isChanged = true
            self.perform(#selector(self.makeViewInteractive), with: nil, afterDelay: 0.5)
            self.tblScrolling.reloadData()
            UIView.animate(withDuration: 0.1) {
                self.viewDidLayoutSubviews()
            }
        }
        else
        {
            //Up
            print("up")
            isMinimize = false
            isChanged = true
            self.perform(#selector(self.makeViewInteractive), with: nil, afterDelay: 0.5)
            self.tblScrolling.reloadData()
            UIView.animate(withDuration: 0.1) {
                self.viewDidLayoutSubviews()
            }
        }
    }
    
    @objc func makeViewInteractive()
    {
        isChanged = false
    }
    
    //MARK:-
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isMinimize ? 1 : textStickers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = textStickers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ScrollingCell
        cell.lblStickerText.text = text
        cell.lblStickerText.textAlignment = .center
        cell.lblStickerText.layer.cornerRadius = cell.lblStickerText.frame.height/2.0
        cell.lblStickerText.layer.masksToBounds = true
        cell.initializeCell()
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var arrCount = isMinimize ? 1 : textStickers.count
        if arrCount > maxCellCount {
            arrCount = maxCellCount
        }
        cellSize = Int(tableView.frame.size.height) / arrCount
        if cellSize > 40 {
            cellSize = 40
        }
        return CGFloat(cellSize)
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
