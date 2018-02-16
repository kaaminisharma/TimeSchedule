//
//  TypeApplianceTableViewController.h
//  TimeSchedule
//
//  Created by Kamini Sharma on 20/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sendDataBackDelegate.h"

@interface TypeApplianceTableViewController : UITableViewController<sendDataBackDelegate>

@property(nonatomic,retain)NSString *buttonType;
@property(nonatomic,retain)NSArray *roomType,*roomAppliance;
@property(nonatomic,retain)id<sendDataBackDelegate> delegate;

@end
