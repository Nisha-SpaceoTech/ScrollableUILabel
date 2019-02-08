//
//  ScrollingCell.swift
//  ScrollingDemo
//
//  Created by on 21/12/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit

class ScrollingCell: UITableViewCell {

    @IBOutlet weak var lblStickerText: UILabel!
    @IBOutlet weak var lblLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblTrailingConstraint: NSLayoutConstraint!
    
    var isStart = false
    var isEnd = false
    var startEnd = 0 as CGFloat
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initializeCell(){
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(handlePanGesture(panGesture:)))
        lblStickerText.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: lblStickerText.superview)
        let location = panGesture.location(in: lblStickerText.superview)
        let scrollVar = (lblStickerText.frame.origin.x + 35) as CGFloat
        let scrollVar2 = (lblStickerText.frame.size.width + lblStickerText.frame.origin.x - 35) as CGFloat
        if panGesture.state == UIGestureRecognizer.State.began {
            isStart = false
            isEnd = false
            startEnd = 0
            if (location.x < scrollVar) {
                isStart = true
                startEnd = lblStickerText.frame.size.width + lblStickerText.frame.origin.x
            }
            else if (location.x > scrollVar2) {
                isEnd = true
            }
            else
            {
                
            }
            // add something you want to happen when the Label Panning has started
        }
        
        if panGesture.state == UIGestureRecognizer.State.ended {
            isStart = false
            isEnd = false
            startEnd = 0
            // add something you want to happen when the Label Panning has ended
        }
        
        if panGesture.state == UIGestureRecognizer.State.changed {
            if isStart {
                if (lblStickerText.frame.origin.x + translation.x<0) {
                    lblStickerText.frame = CGRect(x: 0, y:lblStickerText.frame.origin.y, width:startEnd ,height:lblStickerText.frame.size.height)
                    
                    panGesture.setTranslation(CGPoint.zero, in: lblStickerText.superview)
                }
                else if (startEnd-(lblStickerText.frame.origin.x + translation.x)<20) {
                    
                }
                else {
                    lblStickerText.frame = CGRect(x: lblStickerText.frame.origin.x + translation.x, y:lblStickerText.frame.origin.y, width:startEnd-(lblStickerText.frame.origin.x + translation.x) ,height:lblStickerText.frame.size.height)
                    
                    panGesture.setTranslation(CGPoint.zero, in: lblStickerText.superview)
                }
            }
            else if isEnd {
                let widthNew = lblStickerText.frame.origin.x + translation.x+lblStickerText.frame.size.width as CGFloat
                if widthNew > lblStickerText.superview?.frame.size.width ?? 0 {
                    
                }
                else if widthNew < 20 {
                    
                }
                else
                {
                    lblStickerText.frame = CGRect(x: lblStickerText.frame.origin.x, y:lblStickerText.frame.origin.y, width: translation.x+lblStickerText.frame.size.width ,height:lblStickerText.frame.size.height)
                    panGesture.setTranslation(CGPoint.zero, in: lblStickerText.superview)
                }
            }
            else
            {
                if (lblStickerText.center.x + translation.x - (lblStickerText.frame.size.width/2)) < 0 {
                    
                }
                else if (lblStickerText.center.x + (lblStickerText.frame.size.width/2) + translation.x) > lblStickerText.superview?.frame.size.width ?? 0 {
                    NSLog("call unwanted")
                }
                else
                {
                    lblStickerText.center = CGPoint(x: lblStickerText.center.x + translation.x, y: lblStickerText.center.y)
                    panGesture.setTranslation(CGPoint.zero, in: lblStickerText.superview)
                }
            }
        } else {
            // or something when its not moving
        }
    }

}
