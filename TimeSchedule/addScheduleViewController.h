//
//  addScheduleViewController.h
//  TimeSchedule
//
//  Created by Kamini Sharma on 13/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sendDataBackDelegate.h"

@interface addScheduleViewController : UIViewController<sendDataBackDelegate>
@property (weak, nonatomic) IBOutlet UITextField *scheduleNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *roomTypeTxt;
@property (weak, nonatomic) IBOutlet UITextField *applianceTxt;
@property (weak, nonatomic) IBOutlet UIButton *roomBtn;
@property (weak, nonatomic) IBOutlet UIButton *applianceBtn;

- (IBAction)getRoomApplianceType:(id)sender;


@property (weak, nonatomic) IBOutlet UIDatePicker *timePick;

@property (weak, nonatomic) IBOutlet UIButton *sunBtn;
@property (weak, nonatomic) IBOutlet UIButton *monBtn;
@property (weak, nonatomic) IBOutlet UIButton *tueBtn;
@property (weak, nonatomic) IBOutlet UIButton *wedBtn;
@property (weak, nonatomic) IBOutlet UIButton *thuBtn;
@property (weak, nonatomic) IBOutlet UIButton *friBtn;
@property (weak, nonatomic) IBOutlet UIButton *satBtn;


- (IBAction)clickBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
- (IBAction)updateClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)deleteBtnClick:(id)sender;

@property(nonatomic,retain)NSMutableArray *daysArray;
@property(nonatomic,retain)NSMutableString *daysString;

@property(nonatomic,retain)NSMutableString *schName;
@property BOOL flag;

-(void)showDaysSelected:(NSMutableArray *)selectedDaysArray;

@end


