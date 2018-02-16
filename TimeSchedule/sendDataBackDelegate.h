//
//  sendDataBackDelegate.h
//  TimeSchedule
//
//  Created by Kamini Sharma on 20/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol sendDataBackDelegate <NSObject>

@optional
-(void)getRoomTypeData:(NSString *)data;
-(void)getRoomApplianceData:(NSString *)data;

@end
