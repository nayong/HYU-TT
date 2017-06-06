//
//  SubjectViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 5. 17..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!

    var majorSubjects:[Subject] = []
    var liberalSubjects:[Subject] = []
    
    var views = [UIView]()
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var snap:UISnapBehavior!
    var previousTouchPoint:CGPoint!
    var viewDragging = false
    var viewPinned = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        
        animator.addBehavior(gravity)
        gravity.magnitude = 4
        
        var offset:CGFloat = 50
        if let view = addViewController(atOffset: offset, dataForVC: nil){
            views.append(view)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func addViewController (atOffset offset:CGFloat, dataForVC:AnyObject?) -> UIView? {

        let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.view.bounds.size.height - offset)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let MyChoice = sb.instantiateViewController(withIdentifier: "ChoiceTable") as! ChoiceTableViewController
        
        if let view = MyChoice.view {
            view.frame = frameForView
            view.layer.cornerRadius = 5
            view.layer.shadowOffset = CGSize(width: 2, height: 3)
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowRadius = 3
            view.layer.shadowOpacity = 0.5
            
            
            self.addChildViewController(MyChoice)
            self.view.addSubview(view)
            MyChoice.didMove(toParentViewController: self)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SubjectViewController.handlePan(gestureRecognizer:)))
            view.addGestureRecognizer(panGestureRecognizer)
            
            
            let collision = UICollisionBehavior(items: [view])
            collision.collisionDelegate = self
            animator.addBehavior(collision)
            
            let boundary = view.frame.origin.y + view.frame.size.height - 50
            
            //lower boundary
            var boundaryStart = CGPoint(x: 0, y: boundary)
            var boundaryEnd = CGPoint(x: self.view.bounds.size.width, y: boundary)
            collision.addBoundary(withIdentifier: 1 as NSCopying, from: boundaryStart, to: boundaryEnd)
            
            //upper boundary
            boundaryStart = CGPoint(x:0, y:0)
            boundaryEnd = CGPoint(x: self.view.bounds.size.width, y: 0)
            collision.addBoundary(withIdentifier: 2 as NSCopying, from: boundaryStart, to: boundaryEnd)
            
            gravity.addItem(view)
            
            let itemBehavior = UIDynamicItemBehavior(items: [view])
            animator.addBehavior(itemBehavior)
            
            return view
        }
        return nil
    }
    
    func handlePan (gestureRecognizer:UIPanGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: self.view)
        let draggedView = gestureRecognizer.view!
        
        if gestureRecognizer.state == .began {
            let dragStartPoint = gestureRecognizer.location(in: draggedView)
            
            if dragStartPoint.y < 200 {
                viewDragging = true
                previousTouchPoint = touchPoint
            }
        } else if gestureRecognizer.state == .changed && viewDragging {
            let yOffset = previousTouchPoint.y - touchPoint.y
            
            draggedView.center = CGPoint(x: draggedView.center.x, y: draggedView.center.y - yOffset)
            previousTouchPoint = touchPoint
        }else if gestureRecognizer.state == .ended && viewDragging {
            
            //pin
            pin(view: draggedView)
            //addVelocity
            
            animator.updateItem(usingCurrentState: draggedView)
            viewDragging = false
        }
    }
    
    func pin (view:UIView) {
        let viewHasRechedPinLocation = view.frame.origin.y < 500
        
        if viewHasRechedPinLocation {
            if !viewPinned {
                var snapPosition = self.view.center
                snapPosition.y += 370
                
                snap = UISnapBehavior(item: view, snapTo : snapPosition)
                animator.addBehavior(snap)

                // setVisibility
                setVisibility(view: view, alpha: 0)
                
                viewPinned = true
            }
        }else{
            if viewPinned {
                animator.removeBehavior(snap)
                // setVisibility alpha 1
                setVisibility(view: view, alpha: 1)
                viewPinned = false
            }
        }
    }
    
    func setVisibility (view: UIView, alpha:CGFloat) {
        for aView in views {
            if aView != view {
                aView.alpha = alpha
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MakeTT(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let Tabbar = sb.instantiateViewController(withIdentifier: "Tabbar") as! TabBarController
        
        Tabbar.selectedIndex = 2
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /* 전공/교양 따라 페이지 바꿈 */
    @IBAction func showContainer(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            self.liberalSubjects = MySubjects.subjects
            MySubjects.subjects = self.majorSubjects
            MySubjects.isChanged = true
            UIView.animate(withDuration: 0.5, animations: {
                    self.firstView.alpha = 0.0
                    self.secondView.alpha = 1.0
            })
        }else{
            self.majorSubjects = MySubjects.subjects
            MySubjects.subjects = self.liberalSubjects
            MySubjects.isChanged = true
            UIView.animate(withDuration: 0.5, animations: {
                self.firstView.alpha = 1.0
                self.secondView.alpha = 0.0
            })
        }
        
        
    }

}
