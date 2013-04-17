//
//  motionView.m
//  clock002
//
//  Created by KitamuraShogo on 13/02/20.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import "motionView.h"
#import "ViewController.h"
#import "mainViewController.h"

#define MY_BANNER_UNIT_ID @"a1512da356ee8f4"


@interface motionView ()
@end

@implementation motionView

- (void)sefParrentViewController:(ViewController*)ctrl
{
    parrentCtrl = ctrl;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
  }

- (void)viewDidLoad
{
    [super viewDidLoad];
    TimeLabel = [[UILabel alloc]init];
    TimeLabel.frame = CGRectMake(0, 200, 300, 80);
    TimeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:TimeLabel];
    
    TaskLabel = [[UILabel alloc]init];
    TaskLabel.frame = CGRectMake(0, 280, 300, 80);
    TaskLabel.textColor = [UIColor blackColor];
    [self.view addSubview:TaskLabel];
    
    UIImage *nomalImage = [UIImage imageNamed:@"wakeup.jpg"];
    UIImageView *image = [[UIImageView alloc]initWithImage:nomalImage];
    image.frame = CGRectMake(0, 0, 320, 200);  // 100x100サイズのUIImageViewを作成し
    image.center = CGPointMake(160, 100);  // 200,10
    [self.view addSubview:image];
    
    [self admobView];//admob生成。
}

- (void)viewWillAppear:(BOOL)animated
{
    [self viewDidAppear:animated];
    
    //何回目のalertで押されたの判別して正しい数字にして返してくれる。
  //  [parrentCtrl alertViewChange:self];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    money = [userDefaults integerForKey:@"time2"];
    
    if (money == 0) {
        NSLog(@"%d",money);
        
        TimeLabel.text = [NSString stringWithFormat:@"時間通り!!!!!!!!!!!!!"];

    }else if(money != 0){
    
    TimeLabel.text = [NSString stringWithFormat:@"あなたは%d円無駄にしています。", money];
    NSLog(@"%@",TimeLabel.text);
        
    }
    NSString *pickerTask = [userDefaults objectForKey:@"pickerTask"];
    TaskLabel.text = pickerTask;
    
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
    UIImage* image = [UIImage imageWithData:imageData];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];

    iv.frame = CGRectMake(0, 0, 320, 200);  // 100x100サイズのUIImageViewを作成し
    iv.center = CGPointMake(160, 100);  // 200,10
    [self.view addSubview:iv];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)motionBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    
        
     //閉じるときにtextに書いてある値を保存し直す。
        ViewController *ctrl = [self parentViewController];
    
        [parrentCtrl resetAlermAlert];
        [parrentCtrl switchClick:self];
        
        [self save];
        
    }];
}

-(void)save{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:mainView.TimeIsMoney.text forKey:@"time"];
    NSLog(@"%@",userDefaults);
    [userDefaults synchronize];
    
}
//Admob
-(void)admobView{
    
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView_.frame = CGRectMake(0,410,320,50);
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;
    bannerView_.rootViewController = self;
    
    [self.view addSubview:bannerView_];
    
    GADRequest *request = [GADRequest request];
    request.testing = YES;
    [bannerView_ loadRequest:request];
    
}

- (void)dealloc {
    [super dealloc];
}
@end
