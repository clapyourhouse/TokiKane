//
//  motionView.h
//  clock002
//
//  Created by KitamuraShogo on 13/02/20.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"


@class ViewController;
@class mainViewController;
@interface motionView : UIViewController<GADBannerViewDelegate>{
    UILabel *TimeLabel;
    UILabel *TaskLabel;
    int money;
    ViewController *parrentCtrl;
    mainViewController *mainView;
    
    GADBannerView *bannerView_;
}

- (IBAction)motionBack:(id)sender;

- (void)sefParrentViewController:(ViewController*)ctrl;
//Admob
-(void)admobView;

@end
