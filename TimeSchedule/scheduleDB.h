//
//  scheduleDB.h
//  TimeSchedule
//
//  Created by Kamini Sharma on 20/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface scheduleDB : NSObject
{
    // creating a buffer pointer (db) to execute queries , after then write them to main database memory
    sqlite3 *scheduleDatabase;
}

@property(nonatomic,retain) NSMutableArray *scheduleInfoArray;

// singleton class method
+(instancetype)getSharedObject;

// create database and execute other queries
-(void)createDatabase;
-(NSString *)getDatabasePath;
-(BOOL)executeQuery:(NSString *)query;
-(void)getAllRecords:(NSString *)query;

@end
