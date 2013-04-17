//
//  mainViewController.m
//  clock002
//
//  Created by KitamuraShogo on 13/02/19.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import "mainViewController.h"
#import "creditView.h"
#import "ViewController.h"
#import "settingViewController.h"
@interface mainViewController ()
@end

@implementation mainViewController
@synthesize Tasks;
@synthesize TimeIsMoney;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _CharaImage = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //時給。
    TimeIsMoney = [[[UITextField alloc]initWithFrame:CGRectMake(20,195,150,30)] autorelease];
    TimeIsMoney.borderStyle = UITextBorderStyleRoundedRect;
    TimeIsMoney.placeholder = @"¥";
    TimeIsMoney.keyboardType = UIKeyboardTypeNumberPad;
    TimeIsMoney.backgroundColor = [UIColor clearColor];
    TimeIsMoney.returnKeyType = UIReturnKeyDone;
    TimeIsMoney.delegate = self;
    [TimeIsMoney addTarget:self action:@selector(closeDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:TimeIsMoney];
    //    //過去の値読み込み。
    //    int i = [[NSUserDefaults standardUserDefaults]integerForKey:@"time"];
    //    NSString * str = [NSString stringWithFormat:@"%d",i];
    //    TimeIsMoney.text = str;
    //タスクの選択。
    picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    picker.delegate = self;
    picker.dataSource = self;
    picker.showsSelectionIndicator = YES;
    //pickerカスタマイズ。
    CGAffineTransform t0 = CGAffineTransformMakeTranslation(picker.bounds.size.width/2, picker.bounds.size.height/0.33);//pickerの位置。
    CGAffineTransform s0 = CGAffineTransformMakeScale(0.7, 0.51);//pickerのサイズ。
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(-picker.bounds.size.width/2.3, -picker.bounds.size.height/2);
    picker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
    [self.view addSubview:picker];
    
    //タスク一覧。
    Tasks = [[NSMutableArray alloc]initWithObjects:@"英語",@"受験勉強",@"プログラミング",@"資格", nil];
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

/**
 * ピッカーに表示する行数を返す
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [Tasks count];
}

//表示するものを設定。
- (NSString*)pickerView: (UIPickerView*)pView
            titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    return [Tasks objectAtIndex:row];
}



//キーボード閉じ。
-(void)closeDone:(id)sender{
    [TimeIsMoney resignFirstResponder];
    [task resignFirstResponder];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:TimeIsMoney.text forKey:@"time"];
    NSLog(@"%@",userDefaults);
    [userDefaults synchronize];

}
//
//-(void)save{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setValue:TimeIsMoney.text forKey:@"time"];
//    NSLog(@"%@",userDefaults);
//    [userDefaults synchronize];
//     
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//使い方画面へ。
- (IBAction)HowToBtn:(UIBarButtonItem *)sender {
    creditView *credit = [[creditView alloc]init];
    credit.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:credit animated:YES completion:nil];

}

//時間設定画面へ。
- (IBAction)TimeBtn:(UIBarButtonItem *)sender {
    ViewController *viewController = [[ViewController alloc]init];
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:viewController animated:YES completion:nil];    
  
    //タスクが選択されたらアラーム。
    //選択した行のテキストをmessageに代入します。
    NSString *activity = [Tasks objectAtIndex: [picker selectedRowInComponent:0]];
    NSString *message = [[NSString alloc] initWithFormat: @"%@", activity];
    NSUserDefaults *defaultss = [NSUserDefaults standardUserDefaults];
    [defaultss setObject:message forKey:@"pickerTask"];
    [defaultss synchronize];
    
    //選択した行のテキストをアラートで表示させています。
    //messageに代入されているので、messageを表示させれば大丈夫です。
    UIAlertView* alert = [[[UIAlertView alloc] init] autorelease];
    alert.message = message;
    [alert addButtonWithTitle:@"OK"];
    [alert show];
}





- (void)viewWillAppear:(BOOL)animated
{
    [self viewDidAppear:animated];
    
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
    NSString *imageName = [[NSUserDefaults standardUserDefaults] objectForKey:@"imagename"];
//    UIImage* image = [UIImage imageWithData:imageData];
    if ( imageName == nil ) {
        // セーブデータが無い時はこの画像を使う
        imageName = @"wakeup.jpg";
    }
    UIImage* image = [UIImage imageNamed:imageName];

    if ( _CharaImage == nil ) {
        // 存在していない（初めての画面表示）ときは生成・貼付け
        _CharaImage = [[UIImageView alloc] initWithImage:image];
        _CharaImage.frame = CGRectMake(0, 0, 320, 380);  // 100x100サイズのUIImageViewを作成し
        _CharaImage.center = CGPointMake(160, 150);  // 200,10
        [self.view addSubview:_CharaImage];
        [self.view.layer insertSublayer:_CharaImage.layer atIndex:4];
    }else {
        // すでに存在している場合は、画像の差し替えのみ
        [_CharaImage setImage:image];
    }
}

- (void)dealloc {
    [_CharaImage release];
    [super dealloc];
}
@end
