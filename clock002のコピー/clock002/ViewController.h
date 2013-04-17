//
//  ViewController.h
//  clock002
//
//  Created by KitamuraShogo on 13/02/05.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController{
    
    IBOutlet UILabel *display;
    NSTimer *timer;
    NSArray *images;
    IBOutlet UIImageView *imageView;
    IBOutlet UIDatePicker *datePicker;
    NSDate *alarmTime;//アラーム時間。
    AVAudioPlayer *alarmPlayer;
    BOOL alarmEnabled; //アラームの状態。
    IBOutlet UISwitch *alarmSwitch;//アラームスイッチ。
    UIAlertView *alert;
    //試しにアニメーション。
    UIImageView *iv;
    UIImageView *iv2;
    
    // アラートを出すフラグ(YESなら表示したので出さない)
    BOOL alermShowedFlag;
    
    int money;
    
    int nextAlertTag;
    NSTimer *snoozeTimer;
}
@property(nonatomic,retain)UISwitch *alermSwitch;


-(void)driveClock:(NSTimer*)timer;
-(void)setAlerm:(NSDate*)w_alermTime;
-(NSDate*)getAlerm;
-(void)setAlermEnable:(BOOL)w_alermEnable;
-(BOOL)getAlermEnable;

- (IBAction)setAlerm1:(id)sender;
- (IBAction)switchClick:(id)sender;
- (IBAction)creditView:(id)sender;
- (IBAction)closeBtn:(id)sender;
- (void)resetAlermAlert;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)alertViewChange:(UIAlertView*)al;

@end
