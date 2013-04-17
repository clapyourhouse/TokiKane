//
//  mainViewController.h
//  clock002
//
//  Created by KitamuraShogo on 13/02/19.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    UITextField *TimeIsMoney;
    UITextField *task;
    
    UIPickerView *picker;
    NSMutableArray *Tasks;
}

@property (retain, nonatomic) IBOutlet UIImageView *CharaImage;
@property(nonatomic,retain)NSMutableArray *Tasks;
@property(nonatomic,retain)UITextField *TimeIsMoney;

-(void)closeDone:(id)sender;
-(void)save;

- (IBAction)HowToBtn:(UIBarButtonItem *)sender;
- (IBAction)TimeBtn:(UIBarButtonItem *)sender;
@end
