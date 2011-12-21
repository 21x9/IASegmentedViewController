//
//  IASegmentedViewController.h
//  IASegmentedViewController
//
//  Created by Mark Adams on 12/20/11.
//  Copyright (c) 2011 Interstellar Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    IASegmentedControlPositionTop,
    IASegmentedControlPositionBottom
} IASegmentedControlPosition;

@interface IASegmentedViewController : UIViewController

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong, readonly) UIViewController *activeViewController;
@property (nonatomic, strong, readonly) UISegmentedControl *segmentedControl;
@property (nonatomic, assign) IASegmentedControlPosition segmentedControlPosition;

- (id)initWithViewControllers:(NSArray *)controllers segmentedControlPosition:(IASegmentedControlPosition)position;

@end
