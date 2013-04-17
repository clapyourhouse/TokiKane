//
//  lockView.m
//  clock002
//
//  Created by KitamuraShogo on 13/03/14.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//


#import "lockView.h"
#import "ViewController.h"
#import "motionView.h"
@interface lockView ()

@end

@implementation lockView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
                // Custom initialization
            }
        return self;
    }

- (void)viewDidLoad
{
        [super viewDidLoad];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(driveClock2:) userInfo:nil repeats:YES];//一秒ごとこのメソッドが呼び出される。
    
    
        // Do any additional setup after loading the view from its nib.
    }
-(void)driveClock2:(NSTimer*)timer{
    
        NSDate *today = [NSDate date];//現在時刻の取得
        NSCalendar *calender = [NSCalendar currentCalendar];//時分秒を取得。
        unsigned flags = NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
        NSDateComponents *todayComponents = [calender components:flags fromDate:today];
        int hour = [todayComponents hour];
        int min = [todayComponents minute];
        int sec = [todayComponents second];
        display.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec];//時間を表示。
    
    }
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
        if (alertView.tag = 10) {
        
                if (buttonIndex == 0) {
            
            
            
                    }else{
                
                            [self dismissViewControllerAnimated:YES completion:nil];
                
                        }
        
            }
    
    }

-(void)alertViewAlert{
    
        alert = [[UIAlertView alloc]initWithTitle:@"この設定でよろしいですか？"
                                                        message:@"はは"
                                                       delegate:self
                                              cancelButtonTitle:@"はい"
                                              otherButtonTitles:@"もう一度設定する", nil];
    
        alert.tag = 10;
    
        [alert show];
    
    }

- (void)viewWillAppear:(BOOL)animated
{
        [self viewDidAppear:animated];
    
        [self alertViewAlert];
        //この画面が呼ばれたら生成してタイマーが作動する。
        ViewController *view =  [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
        [view driveClock:(NSTimer*)timer];
    
    
    }
-(void)lockMove{
        motionView *motion = [[motionView alloc]init];
        [self presentViewController:motion animated:YES completion:nil];
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [display release];
    [super dealloc];
}
@end
