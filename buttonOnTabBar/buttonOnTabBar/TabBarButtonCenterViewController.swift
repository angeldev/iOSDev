//
//  TabBarButtonCenterViewController
//  buttonOnTabBar
//
//  Created by Ángel David Macho Esperilla on 12/02/2016.
//

import UIKit

class TabBarButtonCenterViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Creates image of the Button
        let imageCameraButton: UIImage! = UIImage(named: "cameraCircularIcon")
        // If the image is not circular
        // let imageCameraButton: UIImage! = UIImage(named: "cameraIcon")
        
        // Creates a Button
        let cameraButton = UIButton(type: .Custom)
        // Sets width and height to the Button
        cameraButton.frame = CGRectMake(0.0, 0.0, imageCameraButton.size.width, imageCameraButton.size.height)
        // Sets image to the Button
        cameraButton.setBackgroundImage(imageCameraButton, forState: .Normal)
        // Sets the center of the Button to the center of the TabBar. How to set the center of the button depends if the image is circular and its height is bigger than the tabBar
        let heightDifference: CGFloat = imageCameraButton.size.height - self.tabBar.frame.size.height
        if heightDifference < 0 {
            cameraButton.center = self.tabBar.center
        } else {
            var center: CGPoint = self.tabBar.center
            center.y = center.y - heightDifference / 2.0
            cameraButton.center = center
        }
        // Sets an action to the Button
        cameraButton.addTarget(self, action: "doSomething", forControlEvents: .TouchUpInside)
        
        // Adds the Button to the view
        self.view.addSubview(cameraButton)
        
    }
    
    func doSomething() {
        
        let alertController: UIAlertController = UIAlertController(title: nil, message: "Action of the button", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}