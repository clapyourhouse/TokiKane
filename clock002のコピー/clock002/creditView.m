//
//  creditView.m
//  clock002
//
//  Created by KitamuraShogo on 13/02/16.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import "creditView.h"
#import "ViewController.h"

@interface creditView ()

@end

@implementation creditView

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
    
    
    NSString* path = @"http://www.google.co.jp/images/nav_logo7.png";
    NSURL* url = [NSURL URLWithString:path];
    NSData* data = [NSData dataWithContentsOfURL:url];
    UIImage* img = [[UIImage alloc] initWithData:data];
    UIImageView* imgview = [[UIImageView alloc] initWithImage:img];
    //一回しか処理しない。
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        alert = [[UIAlertView alloc]initWithTitle:@"How To" message:@"まず、時給とタスクを設定します。\n 時間を設定してOffをOnにします\n\nおやすみなさい!!!!!!!" delegate:self cancelButtonTitle:@"もういいです" otherButtonTitles:@"２/３へ", nil];
        alert.tag = 1;
        UIImageView* image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wakeup.jpg"]];
        
        image.frame = CGRectMake(0, 0, 220, 140);//画像の大きさ
        image.center = CGPointMake(142, 110);//画像の場所
        [alert addSubview:image];
        [alert show];
        [image release];
    });
}

//alertViewの設定。
- (void)willPresentAlertView:(UIAlertView *)alertView{
        CGRect frame = alertView.frame;
    
        frame.origin.y = 50
    ;//alertの大きさ、範囲。
        frame.size.height = 360;
        alertView.frame = frame;
    
    //alert内容の位置。
        for (UIView* view in alertView.subviews){
            frame = view.frame;
            if (frame.origin.y > 44) {
                frame.origin.y += 160;
                view.frame = frame;
            
        }
    }
}

//2つめ以降のalert処理。
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            //キャン処理
        
        }else{
            //OK処理
            alert = [[UIAlertView alloc]initWithTitle:@"How To" message:@"アプリを起動したまま寝てください。" delegate:self cancelButtonTitle:@"もういいから" otherButtonTitles:@"３/３へ", nil];
            alert.tag = 2;
            [alert show];
                   
        }
    }else if (alertView.tag == 2){
        if (buttonIndex == 0) {
     
            //キャンセル。
        }else{
            
            //OK処理
            alert = [[UIAlertView alloc]initWithTitle:@"How To" message:@"あなたの目標が達成できることを願っています!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"End", nil];
            [alert show];
            
            
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
