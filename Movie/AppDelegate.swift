//
//  AppDelegate.swift
//  Movie
//
//  Created by kathy yin on 4/2/17.
//  Copyright © 2017 kathy. All rights reserved.
//

import UIKit
import AFNetworking
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var netWorkerroView: NetWorkErrorView?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
       
        let nowPlayingNavigationController = storyBoard.instantiateViewController(withIdentifier: "MovieNavigationController") as! UINavigationController
        
        let nowPlayingViewController = nowPlayingNavigationController.topViewController as! MoviewController
        nowPlayingViewController.endPoint = .nowPlaying
        nowPlayingNavigationController.tabBarItem.title = "Now Playing"
        
        nowPlayingNavigationController.tabBarItem.image = UIImage(named: "ic_movie")
        
        
        let topRatedNavigationController = storyBoard.instantiateViewController(withIdentifier: "MovieNavigationController") as! UINavigationController
        
        let topRatedViewController = topRatedNavigationController.topViewController as! MoviewController
        topRatedViewController.endPoint = .topRated
        topRatedNavigationController.tabBarItem.image = UIImage(named: "ic_thumb_up")
        topRatedNavigationController.tabBarItem.title = "Top Rated"

        let tabBarController = UITabBarController()
    
        tabBarController.viewControllers = [nowPlayingNavigationController, topRatedNavigationController]
        
        let height = (UIApplication.shared.statusBarFrame.height +
            topRatedNavigationController.navigationBar.frame.height)
        
        netWorkerroView = NetWorkErrorView(frame: CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: 30))
        netWorkerroView?.backgroundColor = .black
        tabBarController.view.addSubview(netWorkerroView!)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        self.netWorkerroView?.isHidden = true
        
        
        //when lost network connection, show the network error
        AFNetworkReachabilityManager.shared().startMonitoring()
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status) in
            switch (status) {
                case .reachableViaWiFi: fallthrough
                case .reachableViaWWAN:
                    self.netWorkerroView?.isHidden = true
                case .notReachable: fallthrough
                default :
                    self.netWorkerroView?.isHidden = false
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

