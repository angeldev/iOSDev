//
//  TabBarViewController.swift
//  buttonOnTabBar
//
//  Created by Ángel David Macho Esperilla on 12/02/2016.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Creates image of the Button
        let imageCameraButton: UIImage! = UIImage(named: "cameraIcon")
        
        // Creates a Button
        let cameraButton = UIButton(type: .Custom)
        // Sets width and height to the Button
        cameraButton.frame = CGRectMake(0.0, 0.0, imageCameraButton.size.width, imageCameraButton.size.height);
        // Sets image to the Button
        cameraButton.setBackgroundImage(imageCameraButton, forState: .Normal)
        // Sets the center of the Button to the center of the TabBar
        cameraButton.center = self.tabBar.center
        // Sets an action to the Button
        cameraButton.addTarget(self, action: "doSomething", forControlEvents: .TouchUpInside)
        
        // Adds the Button to the view
        self.view.addSubview(cameraButton)
        
    }
    
    func doSomething() {
        
        print("Action of camera button")
        
    }
    
}
