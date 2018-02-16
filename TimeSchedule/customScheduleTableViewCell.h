//
//  customScheduleTableViewCell.h
//  TimeSchedule
//
//  Created by Kamini Sharma on 14/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customScheduleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scheduleNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *onOffLbl;
@property (weak, nonatomic) IBOutlet UILabel *daysLbl;

@end
