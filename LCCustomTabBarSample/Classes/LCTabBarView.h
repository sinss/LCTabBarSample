//
//  LCTabBarView.h
//  LCCustomTabBarSample
//
//  Created by Leo on 5/30/15.
//  Copyright (c) 2015 Perfectidea Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultFontLight @"HelveticaNeue-Light"
#define kTabBarBackgroundColor [UIColor lightGrayColor]
#define kTextHightLightColor [UIColor cyanColor]
#define kTextTintColor [UIColor whiteColor]

static const CGFloat LCAnimationDuration = 0.1f;
static const CGFloat LCTabBarViewHeight = 60.f;

@protocol LCTabBarViewDelegate;
@interface LCTabBarView : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *itemNames;
@property (nonatomic, strong) NSMutableArray *tabButtons;
@property (nonatomic, strong) NSMutableArray *tabLabels;

@property (nonatomic, weak) id <LCTabBarViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray*)items itemNames:(NSArray*)names;

- (IBAction)tabItemPress:(id)sender;

@end

@protocol LCTabBarViewDelegate <NSObject>

- (void)tabItemAtIndex:(NSInteger)index;

@end
