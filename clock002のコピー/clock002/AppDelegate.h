//
//  AppDelegate.h
//  clock002
//
//  Created by KitamuraShogo on 13/02/05.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class mainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) mainViewController *mainViewController;


@end
