//
//  settingViewController.m
//  clock002
//
//  Created by KitamuraShogo on 13/04/01.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import "settingViewController.h"

@interface settingViewController ()

@end

@implementation settingViewController

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
//    //タスクの選択。
//    settingPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    settingPicker.delegate = self;
//    settingPicker.dataSource = self;
//    settingPicker.showsSelectionIndicator = YES;
//    //pickerカスタマイズ。
//    CGAffineTransform t0 = CGAffineTransformMakeTranslation(settingPicker.bounds.size.width/2, settingPicker.bounds.size.height/0.33);//pickerの位置。
//    CGAffineTransform s0 = CGAffineTransformMakeScale(0.7, 0.51);//pickerのサイズ。
//    CGAffineTransform t1 = CGAffineTransformMakeTranslation(-settingPicker.bounds.size.width/2.3, -settingPicker.bounds.size.height/2);
//    settingPicker.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));
//    [self.view addSubview:settingPicker];
//    
//    //タスク一覧。
//    settingTask = [[NSMutableArray alloc]initWithObjects:@"英語",@"受験勉強",@"プログラミング",@"資格", nil];
//    
//
//    // Do any additional setup after loading the view from its nib.
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
    return [settingTask count];
}

//表示するものを設定。
- (NSString*)pickerView: (UIPickerView*)pView
            titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    return [settingTask objectAtIndex:row];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self viewDidAppear:animated];
      
    NSLog(@"あ");
    
}


- (IBAction)settingBtn:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //選択した行のテキストをmessageに代入します。
    NSString *activity = [settingTask objectAtIndex: [settingPicker selectedRowInComponent:0]];
    NSString *message = [[NSString alloc] initWithFormat: @"%@", activity];
    NSUserDefaults *defaultss = [NSUserDefaults standardUserDefaults];
    [defaultss setObject:message forKey:@"SettingPicker"];
    [defaultss synchronize];
    
    //選択した行のテキストをアラートで表示させています。
    //messageに代入されているので、messageを表示させれば大丈夫です。
    UIAlertView* alert = [[[UIAlertView alloc] init] autorelease];
    alert.message = message;
    [alert addButtonWithTitle:@"OK"];
    [alert show];
    

}
- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
