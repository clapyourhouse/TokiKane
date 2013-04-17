//
//  lockView.h
//  clock002
//
//  Created by KitamuraShogo on 13/03/14.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lockView : UIViewController{
    
    IBOutlet UILabel *display;
    NSTimer *timer;
    UIAlertView *alert;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)alertViewAlert;
-(void)lockMove;

@end
