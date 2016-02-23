//
//  TabBarButtonOnTabBarItemViewController.swift
//  buttonOnTabBar
//
//  Created by Ángel David Macho Esperilla on 23/02/2016.
//

import UIKit

class TabBarButtonOnTabBarItemViewController: UITabBarController {

    // Button
    let button = UIButton(type: .Custom)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Sets a transparent button on the second UITabBarItem. In this way when you press the UITabBarItem, instead of go to this item, it launchs an action.
        
        // Gets the subViews of the UITabBarItems
        var tabBarButtonSubViews = [UIView]()
        for tabBarButtonSubView in self.tabBar.subviews {
            if tabBarButtonSubView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                tabBarButtonSubViews.append(tabBarButtonSubView)
            }
        }
        
        // Gets the subView of the second UITabBarItem
        let scannerTabBarButton = tabBarButtonSubViews[1]
        
        // Sets the width and height of the button(the same as the subView of the UITabBarItem)
        self.button.frame = CGRectMake(0.0, 0.0, scannerTabBarButton.frame.width, scannerTabBarButton.frame.height);
        //Sets an action to the button
        self.button.addTarget(self, action: "actionButton", forControlEvents: .TouchUpInside)
        // Sets the position of the button
        self.button.frame.origin.x = self.tabBar.frame.origin.x + scannerTabBarButton.frame.origin.x
        self.button.frame.origin.y = self.tabBar.frame.origin.y
        
        // Adds the button
        self.view.addSubview(self.button)
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        // This code is executed after the screen has rotated
        coordinator.animateAlongsideTransition(nil) {
            _ -> Void in
            
            // When the device rotates, this code reallocates the button on the second UITabBarItem again
            var tabBarButtonSubViews = [UIView]()
            for tabBarButtonSubView in self.tabBar.subviews {
                if tabBarButtonSubView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                    tabBarButtonSubViews.append(tabBarButtonSubView)
                }
            }
            
            let scannerTabBarButton = tabBarButtonSubViews[1]
            
            self.button.frame.origin.x = self.tabBar.frame.origin.x + scannerTabBarButton.frame.origin.x
            self.button.frame.origin.y = self.tabBar.frame.origin.y
            
        }
    }
    
    // The function launched when the button is clicked
    func actionButton() {
        
        let alertController: UIAlertController = UIAlertController(title: nil, message: "Action of the button", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)

        self.presentViewController(alertController, animated: true, completion: nil)
        
    }

}
