//
//  IASegmentedViewController.h
//  IASegmentedViewController
//
//  Created by Mark Adams on 12/20/11.
//  Copyright (c) 2011 Interstellar Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IASegmentedViewController : UIViewController

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong, readonly) UIViewController *activeViewController;
@property (nonatomic, strong, readonly) UISegmentedControl *segmentedControl;

- (id)initWithViewControllers:(NSArray *)controllers;

@end
