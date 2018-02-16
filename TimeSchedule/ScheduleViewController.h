//
//  ScheduleViewController.h
//  TimeSchedule
//
//  Created by Kamini Sharma on 13/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScheduleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *allScheduleTable;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
