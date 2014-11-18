//
//  TabBarViewController.swift
//  Assignment5
//
//  Created by Cemre Güngör on 11/17/14.
//  Copyright (c) 2014 cemre. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var trendingButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var selectedButton: UIButton!
    var selectedViewController: UIViewController!
    
    var homeViewController: HomeViewController!
    var searchViewController: SearchViewController!
    var trendingViewController: TrendingViewController!
    var accountViewController: AccountViewController!
    var composeViewController: ComposeViewController!
    
    var isPresenting: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        homeButton.setImage(UIImage(named: "home_selected_icon"), forState: UIControlState.Selected)
        searchButton.setImage(UIImage(named: "search_selected_icon"), forState: UIControlState.Selected)
        accountButton.setImage(UIImage(named: "account_selected_icon"), forState: UIControlState.Selected)
        trendingButton.setImage(UIImage(named: "trending_selected_icon"), forState: UIControlState.Selected)
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        homeViewController = storyboard.instantiateViewControllerWithIdentifier("home") as HomeViewController
        searchViewController = storyboard.instantiateViewControllerWithIdentifier("search") as SearchViewController
        trendingViewController = storyboard.instantiateViewControllerWithIdentifier("trending") as TrendingViewController
        accountViewController = storyboard.instantiateViewControllerWithIdentifier("account") as AccountViewController
        composeViewController = storyboard.instantiateViewControllerWithIdentifier("compose") as ComposeViewController
    
        
        onTabButton(homeButton)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.frame.origin.y = 568
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.frame.origin.y = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.frame.origin.y = 568
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }


    
    @IBAction func onTabButton(sender: UIButton) {
        if(selectedButton != nil) {
            selectedButton!.selected = false
        }

        sender.selected = true
        selectedButton = sender
        
        if(sender == homeButton) {
            switchViews(homeViewController)
        }
        if(sender == searchButton) {
            switchViews(searchViewController)
        }
        if(sender == trendingButton) {
            switchViews(trendingViewController)
        }
        if(sender == accountButton) {
            switchViews(accountViewController)
        }
        if(sender == composeButton) {
            performSegueWithIdentifier("composeSegue", sender: self)
        }
    }

    
    func switchViews(toViewController: UIViewController) {
        toViewController.view.frame = contentView.frame
        contentView.addSubview(toViewController.view)
        selectedViewController = toViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
