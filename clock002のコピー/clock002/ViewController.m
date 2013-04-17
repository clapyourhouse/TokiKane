//
//  ViewController.m
//  clock002
//
//  Created by KitamuraShogo on 13/02/05.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import "ViewController.h"
#import "creditView.h"
#import "motionView.h"
#import "lockView.h"



#define SNOOZE_NUM  5
// アラートに表示するメッセージ
static NSString *alertMessage[ SNOOZE_NUM ] = {
    @"起きて",
    @"起きるよ",
    @"起きなさい",
    @"起きろ!!!!",
    @"起きろ",
    
};
// 使用する画像ファイル名
static NSString *alertImageName[ SNOOZE_NUM ] = {
    @"wakeup.jpg",
    @"s0.jpg",
    @"s-1.jpg",
    @"s-2.jpg",
    @"s-3.jpg",
};
// 無駄にしたお金の倍率
static double alertMoneyMultiply[ SNOOZE_NUM ] = {
    0,
    1.5,
    1.7,
    1.9,
    2.1,
};


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(driveClock:) userInfo:nil repeats:YES];//一秒ごとこのメソッドが呼び出される。
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"alerm" ofType:@"wav"];
    //鳴らすアラームを設定。
    NSURL *url = [NSURL fileURLWithPath:path];
    alarmPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    alarmPlayer.numberOfLoops = -1;//これで無限ループ。
    
    alarmSwitch.on = NO;//起動時True
  
}

-(void)driveClock:(NSTimer *)timer{
    
    NSDate *today = [NSDate date];//現在時刻の取得
    NSCalendar *calender = [NSCalendar currentCalendar];//時分秒を取得。
    unsigned flags = NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *todayComponents = [calender components:flags fromDate:today];
    int hour = [todayComponents hour];
    int min = [todayComponents minute];
    int sec = [todayComponents second];
    display.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hour,min,sec];//時間を表示。
    
    
    //時間変更。
    if ( alarmTime ) {
        NSDateComponents *alarmComponents = [calender components:flags fromDate:alarmTime];
        int alarmhour = [alarmComponents hour];
        int alarmmin = [alarmComponents minute];
        NSLog(@"hour=>%d min=>%d",alarmhour,alarmmin);
        
        if (alarmEnabled == TRUE) {
            if ((hour == alarmhour && min == alarmmin)) {
                if ( alermShowedFlag ) return;
                
           
                
                [alarmPlayer play];
                
                   //フラグ
                nextAlertTag = 0;
//                    alert = [[UIAlertView alloc]initWithTitle:@"Wake Up!!!!" message:@"起きて" delegate:self cancelButtonTitle:@"はい" otherButtonTitles:@"スヌーズ", nil];
//                    alert.tag = 1;
//                    [alert show];
                
                alermShowedFlag = YES;
                [self showAlert];
                
                

               
            }
        
        }
    }
}

//alertViewのクリック処理。
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        //キャン処理
        [alarmPlayer stop];
        alarmEnabled = FALSE;
        [alert release];
        alert = nil;
        
        //時間通りなので無駄にしてない。おめでとう！！！
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *time = [userDefaults objectForKey:@"time"];
        money = [time intValue];
        money *= alertMoneyMultiply[ alertView.tag ];   // tagを使って切り分ける
        NSUserDefaults *moneyDefaults = [NSUserDefaults standardUserDefaults];
        [moneyDefaults setInteger:money forKey:@"time2"];
        
        UIImage *img = [UIImage imageNamed:alertImageName[ alertView.tag ]];  // tagを使って切り分ける
        iv = [[UIImageView alloc] initWithImage:img];
        NSData *imageData = UIImagePNGRepresentation(img);
        [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"image"];
        [[NSUserDefaults standardUserDefaults] setObject:alertImageName[ alertView.tag ] forKey:@"imagename"];  // tagを使って切り分ける
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // スヌーズ用タイマーを止める
        if ( [snoozeTimer isValid] ) {
            [snoozeTimer invalidate];
        }
       // [self lockMove];
        motionView *motion = [[motionView alloc]init];
        [motion sefParrentViewController:self];
        [self presentViewController:motion animated:YES completion:nil];
        
    }else{
        // スヌーズ処理
        [alarmPlayer stop];
        alarmEnabled = FALSE;
        [alert release];
        alert = nil;
    }
//  
//    if (alertView.tag == 1) {
//        if (buttonIndex == 0) {
//            //キャン処理
//            [alarmPlayer stop];
//            alarmEnabled = FALSE;
//            [alert release];
//            
//            //時間通りなので無駄にしてない。おめでとう！！！
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *time = [userDefaults objectForKey:@"time"];
//            money = [time intValue];
//            money *= 0;
//            NSUserDefaults *moneyDefaults = [NSUserDefaults standardUserDefaults];
//            [moneyDefaults setInteger:money forKey:@"time"];
//            
//            UIImage *img = [UIImage imageNamed:@"wakeup.jpg"];
//            iv = [[UIImageView alloc] initWithImage:img];
//            NSData *imageData = UIImagePNGRepresentation(img);
//            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"image"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"wakeup.jpg" forKey:@"imagename"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            motionView *motion = [[motionView alloc]init];
//            [motion sefParrentViewController:self];
//            [self presentViewController:motion animated:YES completion:nil];
//            
//              }else{
//            //OK処理
//            [alarmPlayer stop];
//            alarmEnabled = FALSE;
//            NSTimer *timerRepeeeat = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerRepeeeat:) userInfo:nil repeats:NO];
//            
//        }
//    }else if (alertView.tag == 2){
//        if (buttonIndex == 0) {
//            [alarmPlayer stop];
//            alarmEnabled = FALSE;
//            [alert release];
//            
//            
//            //1回目の無駄にしてます金額更新。
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *time = [userDefaults objectForKey:@"time"];
//            money = [time intValue];
//            money *= 1.5;
//            NSUserDefaults *moneyDefaults = [NSUserDefaults standardUserDefaults];
//            [moneyDefaults setInteger:money forKey:@"time"];
//                        
//            UIImage *img = [UIImage imageNamed:@"s0.jpg"];
//            iv = [[UIImageView alloc] initWithImage:img];
//            NSData *imageData = UIImagePNGRepresentation(img);
//            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"image"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"s0.jpg" forKey:@"imagename"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//      
//            motionView *motion = [[motionView alloc]init];
//            [motion sefParrentViewController:self];
//            [self presentViewController:motion animated:YES completion:nil];
//
//        }else{
//            //
//            //OK処理
//            [alarmPlayer stop];
//            alarmEnabled = FALSE;
//            NSTimer *timerRepeeeat = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(nextTimer:) userInfo:nil repeats:NO];
//        }
//    }else if (alertView.tag == 3){
//        if (buttonIndex == 0) {
//            [alarmPlayer stop];
//            alarmEnabled = FALSE;
//            [alert release];
//          
//            
//            //2回目の無駄にしてます金額更新。
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *time = [userDefaults objectForKey:@"time"];
//            money = [time intValue];
//            money *= 1.7;
//            NSUserDefaults *moneyDefaults = [NSUserDefaults standardUserDefaults];
//            [moneyDefaults setInteger:money forKey:@"time"];
//            
//            UIImage *img = [UIImage imageNamed:@"s-1.jpg"];
//            iv = [[UIImageView alloc] initWithImage:img];
//            NSData *imageData = UIImagePNGRepresentation(img);
//            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"image"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"s-1.jpg" forKey:@"imagename"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            motionView *motion = [[motionView alloc]init];
//            [motion sefParrentViewController:self];
//            [self presentViewController:motion animated:YES completion:nil];
//            
//        }else{
//            //
//            //OK処理
//            [alarmPlayer stop];
//            alarmEnabled = FALSE;
//            NSTimer *nextTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(nextTimer:) userInfo:nil repeats:NO];
//        }
//
//    }
}

//2回目以降のtimerAlert内容。
-(void)timerRepeeeat:(NSTimer*)timer{
    [alarmPlayer play];
    alert = [[UIAlertView alloc]initWithTitle:@"Wake Up!!!!" message:@"起きなさい" delegate:self cancelButtonTitle:@"もういいから" otherButtonTitles:@"スヌーズ", nil];
    alert.tag = 2;
    [alert show];

}
//3回目以降のTimer
-(void)nextTimer:(NSTimer*)timer{
    [alarmPlayer play];
    alert = [[UIAlertView alloc]initWithTitle:@"Wake Up!!!!" message:@"起きろ" delegate:self cancelButtonTitle:@"もういいから" otherButtonTitles:@"スヌーズ", nil];
    alert.tag = 3;
    [alert show];
    
}
////alert直後に呼び出される。
//-(void)didPresentAlertView:(UIAlertView*)alertView{
////アラートごとより、時間の経過で画像を変えるのがいいんではないか？
//    NSTimer *timerRepeeeat = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(imageChange:) userInfo:nil repeats:NO];//10秒ごとこのメソッドが呼び出される。
//}



- (void)showAlert
{
    if ( alert != nil ) {
        [alert dismissWithClickedButtonIndex:1 animated:NO];
    }
    
    // アラート表示
    [alarmPlayer play];
    alert = [[UIAlertView alloc]initWithTitle:@"Wake Up!!!!"
                                      message:alertMessage[nextAlertTag]
                                     delegate:self
                            cancelButtonTitle:@"もういいから"
                            otherButtonTitles:@"スヌーズ", nil];
    alert.tag = nextAlertTag;
    [alert show];
    
    // スヌーズタイマースタート
    snoozeTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(showAlert) userInfo:nil repeats:NO];//10秒ごとこのメソッドが呼び出される。
    
    // 次のアラーと表示に備える
    nextAlertTag++;
    if ( nextAlertTag >= SNOOZE_NUM ) {
        nextAlertTag = SNOOZE_NUM - 1;
    }
}



//datePickerのやつ。
-(void)setAlerm:(NSDate *)w_alermTime{
    [alarmTime release];
    alarmTime = [w_alermTime retain];
}
-(NSDate*)getAlerm{
    return(alarmTime);
}

- (IBAction)setAlerm1:(id)sender {
    [self setAlerm:datePicker.date];
}

//スイッチのやつ。
-(void)setAlermEnable:(BOOL)w_alermEnable{
    alarmEnabled = w_alermEnable;
}
-(BOOL)getAlermEnable{
    return (alarmEnabled);
}
- (IBAction)switchClick:(id)sender {
    if (alarmSwitch.on == YES) {
        
        lockView *motion = [[lockView alloc]init];
                [self presentViewController:motion animated:YES completion:nil];
        
        lockView *lock =  [[lockView alloc] initWithNibName:@"lockView" bundle:nil];
               // [lock alertViewAlert];
        
        [lock alertView:(UIAlertView*)alert clickedButtonAtIndex:(NSInteger)self];
        
        [self setAlermEnable:TRUE];
        [self driveClock:(NSTimer*)timer];
        
    }else if(alarmSwitch.on == NO){
      
        [self setAlermEnable:FALSE];
        [alarmPlayer stop];
    }
    return;
}

//クレジット画面へ。
- (IBAction)creditView:(id)sender {
    creditView *credit = [[creditView alloc]init];
    credit.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:credit animated:YES completion:nil];
}
//mainViewに戻る。
- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)resetAlermAlert
{
    alarmEnabled = TRUE;
    alermShowedFlag = NO;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self viewDidAppear:animated];
    
    alarmSwitch.on = NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *time = [userDefaults objectForKey:@"time"];
    money = [time intValue];
//    money *= alertMoneyMultiply[ self.alertView.tag ];   // tagを使って切り分ける

    
}

@end
