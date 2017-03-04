//
//  AppDelegate.m
//  FMC
//
//  Created by Nennu on 07/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *savedValue = [[NSUserDefaults standardUserDefaults] valueForKey:@"status"];
    NSLog(@"%@",savedValue);
    if ([savedValue isEqualToString:@"success"]) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        NSString * storyboardIdentifier = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: nil];
        hm =[storyboard instantiateViewControllerWithIdentifier:@"Home"];
        mn=[[Menu alloc]init];
        UINavigationController *home=[[UINavigationController alloc]initWithRootViewController:hm];
        UINavigationController *menu=[[UINavigationController alloc]initWithRootViewController:mn];
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:menu frontViewController:home];
        _window.rootViewController = revealController;
        
        [_window makeKeyAndVisible];
    }
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
     [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
