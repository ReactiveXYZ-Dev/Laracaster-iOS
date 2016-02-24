
import UIKit


struct MHImageTabBarConstants {
    
    static let tabBarBackgroundColor = UIColor(red: 0.92, green: 0.96, blue: 0.95, alpha: 1)
    static let tabBarSeparatorColor = UIColor(red: 0.45, green: 0.77, blue: 0.72, alpha: 1)
    static let tabBarSelectedItemColor = Extensions.colorFromHex("#80cbc4")
    static let tabBarUnselectedItemColor = UIColor(red: 0.65, green: 0.74, blue: 0.71, alpha: 1)
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)

    static let mainViewControllers = [
        
        MainViewController(viewController:UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("WatchViewController") , imageName:"watch"),
        
        
        MainViewController(viewController:UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CatalogueViewController"), imageName: "catalogue"),
        
        
        MainViewController(viewController:UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DiscussionViewController"), imageName: "discussion"),
        
        MainViewController(viewController:UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DownloadsNavigationController"), imageName: "download-tab")
        
    ]
    
    static let RTL = false
    
    static let tabBarAnimationDuration = NSTimeInterval(0.2)
}
