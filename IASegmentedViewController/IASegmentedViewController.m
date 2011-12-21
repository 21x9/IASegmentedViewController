//
//  IASegmentedViewController.m
//  IASegmentedViewController
//
//  Created by Mark Adams on 12/20/11.
//  Copyright (c) 2011 Interstellar Apps. All rights reserved.
//

#import "IASegmentedViewController.h"

@interface IASegmentedViewController ()

@property (nonatomic, strong, readwrite) UIViewController *activeViewController;
@property (nonatomic, strong, readwrite) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) UINavigationBar *navigationBar;
@property (nonatomic, strong) UIToolbar *toolbar;

// View Setup
- (void)setupNavigationBar;
- (void)setupToolbar;
- (void)setupSegmentedControl;

// Segmented Control Management
- (void)reloadSegmentedControl;

// Child View Controller Management
- (void)presentViewControllerAtIndex:(NSInteger)index;
- (void)addViewController:(UIViewController *)viewController;
- (void)removeViewController:(UIViewController *)viewController;

// Child View Management
- (CGRect)frameForChildView;

@end

#pragma mark -

@implementation IASegmentedViewController

#pragma mark - Public Properties
@synthesize viewControllers;
@synthesize activeViewController;
@synthesize segmentedControl;
@synthesize segmentedControlPosition;

#pragma mark - Private Properties
@synthesize navigationBar;
@synthesize toolbar;

#pragma mark - Initialization
- (id)initWithViewControllers:(NSArray *)controllers segmentedControlPosition:(IASegmentedControlPosition)position
{
    NSParameterAssert(controllers && position >= 0 && position < 2);
    
    self = [super init];
    
    if (!self)
        return nil;
    
    viewControllers = controllers;
    segmentedControlPosition = position;
    
    return self;
}

#pragma mark - Setters
- (void)setViewControllers:(NSArray *)controllers
{
    if (viewControllers == controllers)
        return;
    
    for (id viewController in controllers)
        if (![viewController respondsToSelector:@selector(viewDidLoad)])
            [[[NSException alloc] initWithName:NSInternalInconsistencyException reason:@"Attempted to insert an object that does not descend from UIViewController." userInfo:nil] raise];
    
    viewControllers = controllers;
    
    if (self.segmentedControl)
        [self reloadSegmentedControl];
}

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.segmentedControlPosition == IASegmentedControlPositionTop)
        [self setupNavigationBar];
    else
        [self setupToolbar];
    
    [self setupSegmentedControl];
}

#pragma mark - View Setup
- (void)setupNavigationBar
{
    if (self.navigationController)
        return;
    
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    [self.navigationBar pushNavigationItem:self.navigationItem animated:NO];
    [self.view addSubview:self.navigationBar];
}

- (void)setupToolbar
{
    if (self.navigationController)
        return;
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.view.frame) - 44.0f, 320.0f, 44.0f)];
    [self.view addSubview:self.toolbar];
}

- (void)setupSegmentedControl
{
    NSMutableArray *viewControllerTitles = [NSMutableArray array];
    
    for (UIViewController *viewController in self.viewControllers)
        [viewControllerTitles addObject:viewController.title];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:viewControllerTitles];
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentIndexDidChange) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self presentViewControllerAtIndex:0];
    
    CGRect frame = self.segmentedControl.frame;
    frame.size.width = 300.0f;
    self.segmentedControl.frame = frame;
    
    if (self.segmentedControlPosition == IASegmentedControlPositionTop)
        self.navigationItem.titleView = self.segmentedControl;
    else
    {
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl];
        self.toolbar.items = [NSArray arrayWithObject:barItem];
    }
}

#pragma mark - UISegmentedControl Management
- (void)selectedSegmentIndexDidChange
{
    [self presentViewControllerAtIndex:self.segmentedControl.selectedSegmentIndex];
}

- (void)reloadSegmentedControl
{
    [self.segmentedControl removeAllSegments];
    
    for (UIViewController *viewController in self.viewControllers)
        [self.segmentedControl insertSegmentWithTitle:viewController.title atIndex:[self.viewControllers indexOfObject:viewController] animated:YES];
    
    self.segmentedControl.selectedSegmentIndex = 0;
}

#pragma mark - Child View Controller Management
- (void)presentViewControllerAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.viewControllers.count)
        return;
    
    if (self.activeViewController)
        [self removeViewController:self.activeViewController];
    
    [self addViewController:[self.viewControllers objectAtIndex:index]];
}

- (void)addViewController:(UIViewController *)viewController
{
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    viewController.view.frame = self.frameForChildView;
    [viewController didMoveToParentViewController:self];
    self.activeViewController = viewController;
}

- (void)removeViewController:(UIViewController *)controller
{
    [controller willMoveToParentViewController:nil];
    [controller.view removeFromSuperview];
    [controller removeFromParentViewController];
}

#pragma mark Child View Management
- (CGRect)frameForChildView
{
    CGRect frame = CGRectZero;
    frame.size.width = CGRectGetWidth(self.view.frame);

    if (self.segmentedControlPosition == IASegmentedControlPositionTop)
    {
        frame.origin.y = CGRectGetHeight(self.navigationBar.frame);
        frame.size.height = CGRectGetHeight(self.view.frame) - frame.origin.y;
    }
    else
    {
        frame.origin.y = 0.0f;
        frame.size.height = CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.toolbar.frame);
    }

    return frame;
}

@end