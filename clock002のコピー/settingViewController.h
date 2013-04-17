//
//  settingViewController.h
//  clock002
//
//  Created by KitamuraShogo on 13/04/01.
//  Copyright (c) 2013年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface settingViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSMutableArray *settingTask;
    UIPickerView *settingPicker;
}

- (IBAction)backBtn:(id)sender;


@end
