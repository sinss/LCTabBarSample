//
//  LCTabBarView.m
//  LCCustomTabBarSample
//
//  Created by Leo on 5/30/15.
//  Copyright (c) 2015 Perfectidea Inc. All rights reserved.
//

#import "LCTabBarView.h"

const static CGFloat buttonOffset = 10.f;

@implementation LCTabBarView

- (NSMutableArray*)tabButtons
{
    if (!_tabButtons)
    {
        _tabButtons = [NSMutableArray array];
    }
    return _tabButtons;
}

- (NSMutableArray*)tabLabels
{
    if (!_tabLabels)
    {
        _tabLabels = [NSMutableArray array];
    }
    return _tabLabels;
}

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray*)items itemNames:(NSArray*)names
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.items = items;
        self.itemNames = names;
        [self initialize];
        [self setSelectWithIndex:1];
    }
    return self;
}


- (void)initialize
{
    CGFloat currentX = 0;
    CGFloat width = CGRectGetWidth(self.frame) / 3;
    CGFloat height = 40;
    int index = 0;
    for (NSString *name in self.itemNames)
    {
        NSString *imageName = self.items[index];
        @autoreleasepool
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = index;
            button.frame = CGRectMake(currentX, 5, width, height);
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(tabItemPress:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(currentX, 43, width, 15)];
            label.tag = index;
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = kTextTintColor;
            label.highlightedTextColor = kTextHightLightColor;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont fontWithName:kDefaultFontLight size:13];
            label.text = name;
            
            [self addSubview:label];
            [self addSubview:button];
            
            [self.tabButtons addObject:button];
            [self.tabLabels addObject:label];
            
            currentX += width;
        }
        index ++;
    }
    
    [self setupLayer];
}

- (void)setupLayer
{
    self.backgroundColor = kTabBarBackgroundColor;
    //shadow
    CALayer *layer = self.layer;
    layer.shadowOffset = CGSizeMake(0, 3);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOpacity = 10.00f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    layer.masksToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:layer.bounds];
    layer.shadowPath = path.CGPath;
}

- (IBAction)tabItemPress:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if (!button.selected)
    {
        [self resetState];
        [self setSelectWithIndex:button.tag];
        [self.delegate tabItemAtIndex:button.tag];
    }
}

- (void)resetState
{
    for (UIButton *btn in self.tabButtons)
    {
        if (btn.selected)
        {
            [UIView animateWithDuration:0.1 animations:^{
                btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y + buttonOffset, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
                btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL success) {
                
            }];
            btn.selected = NO;
        }
        
    }
    for (UILabel *label in self.tabLabels)
    {
        if (label.highlighted)
        {
            label.highlighted = NO;
        }
    }
}

- (void)setSelectWithIndex:(NSInteger)index
{
    UIButton *btn = self.tabButtons[index];
    btn.selected = YES;
    
    [UIView animateWithDuration:LCAnimationDuration animations:^{
        btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y - buttonOffset, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
        btn.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL success) {
        
    }];
    
    UILabel *label = self.tabLabels[index];
    label.highlighted = YES;
}

@end
