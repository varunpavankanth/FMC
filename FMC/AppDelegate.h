//
//  AppDelegate.h
//  FMC
//
//  Created by Nennu on 07/02/17.
//  Copyright © 2017 versatilemobitech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Home.h"
#import "Menu.h"
#import "SWRevealViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Home *hm;
    Menu *mn;
}

@property (strong, nonatomic) UIWindow *window;


@end

