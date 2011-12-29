//
//  AppDelegate.m
//  IASegmentedViewController
//
//  Created by Mark Adams on 12/20/11.
//  Copyright (c) 2011 Interstellar Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "IASegmentedViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.title = @"Featured";
    vc1.view.backgroundColor = [UIColor lightGrayColor];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"What's Hot";
    vc2.view.backgroundColor = [UIColor darkGrayColor];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.title = @"Top Grossing";
    vc3.view.backgroundColor = [UIColor purpleColor];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.title = @"New";
    vc4.view.backgroundColor = [UIColor magentaColor];
    
    NSArray *viewControllers = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
    
    IASegmentedViewController *svc = [[IASegmentedViewController alloc] initWithViewControllers:viewControllers segmentedControlPosition:IASegmentedControlPositionBottom];
    
    self.window.rootViewController = svc;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;  
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
