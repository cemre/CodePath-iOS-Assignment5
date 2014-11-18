//
//  SearchViewController.swift
//  Assignment5
//
//  Created by Cemre Güngör on 11/17/14.
//  Copyright (c) 2014 cemre. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var loadingImageView: UIImageView!
    
    var images: [UIImage]!
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchImageView.hidden = true
        images = []
        images.append(UIImage(named: "loading-1")!)
        images.append(UIImage(named: "loading-2")!)
        images.append(UIImage(named: "loading-3")!)
        
        loadingImageView.animationImages = images
        loadingImageView.animationDuration = NSTimeInterval(1)
        loadingImageView.startAnimating()
        
        delay(3) {
            self.loadingImageView.hidden = true
            self.searchImageView.hidden = false
        }
        
        
        // Do any additional setup after loading the view.
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
