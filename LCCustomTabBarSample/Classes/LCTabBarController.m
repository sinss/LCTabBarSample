//
//  LCTabBarController.m
//  LCCustomTabBarSample
//
//  Created by Leo on 5/30/15.
//  Copyright (c) 2015 Perfectidea Inc. All rights reserved.
//

#import "LCTabBarController.h"
#import "LCTabBarView.h"

#import "SampleViewController.h"


@interface LCTabBarController () <UITabBarControllerDelegate, LCTabBarViewDelegate>

@property (nonatomic, weak) UIButton *missionButton;
@property (nonatomic, strong) LCTabBarView *tabBarView;


@end

@implementation LCTabBarController

- (LCTabBarView*)tabBarView
{
    if (!_tabBarView)
    {
        _tabBarView = [[LCTabBarView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - LCTabBarViewHeight, CGRectGetWidth(self.view.frame), LCTabBarViewHeight) andItems:@[@"first", @"second", @"third"] itemNames:@[@"first", @"second", @"third"]];
        _tabBarView.delegate  = self;
    }
    return _tabBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    self.delegate = self;
    [self createTabBarView];
    [self createViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self replaceTabItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self.missionButton setSelected:NO];
}

- (void)createTabBarView
{
    [self.view addSubview:self.tabBarView];
}

- (void)createViewControllers
{
#warning create your viewControllers here
    SampleViewController *vc1 = [[SampleViewController alloc] initWithNibName:@"SampleViewController" bundle:nil];
    vc1.labelMessage = @"1";
    
    SampleViewController *vc2 = [[SampleViewController alloc] initWithNibName:@"SampleViewController" bundle:nil];
    vc2.labelMessage = @"2";
    
    SampleViewController *vc3 = [[SampleViewController alloc] initWithNibName:@"SampleViewController" bundle:nil];
    vc3.labelMessage = @"3";
    
    self.viewControllers = @[vc1, vc2, vc3];
    
    self.selectedIndex = 1;
}

- (void)buttonPress:(id)sender
{
    self.selectedIndex = ((UIButton*)sender).tag;
    
    [self.missionButton setSelected:YES];
}

- (void)tabItemAtIndex:(NSInteger)index
{
    self.selectedIndex = index;
}

@end
