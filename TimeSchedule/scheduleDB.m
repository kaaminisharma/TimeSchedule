//
//  scheduleDB.m
//  TimeSchedule
//
//  Created by Kamini Sharma on 20/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import "scheduleDB.h"
#import "scheduleModel.h"

@implementation scheduleDB


+(instancetype)getSharedObject
{
    scheduleDB static *sharedObj;
    if(sharedObj==nil)
    {
        sharedObj=[[scheduleDB alloc]init];
    }
    return sharedObj;
}

// method to create database
-(void)createDatabase
{
    NSString *createTableQuery=@"Create Table if not exists schedule(scheduleName text PRIMARY KEY,roomType text,applianceType text,time text,days text)";
    BOOL success=[self executeQuery:createTableQuery];
    if(success)
    {
        NSLog(@"Table Created Successfully");
    }

}

-(NSString *)getDatabasePath
{
    NSArray *docArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbpath=[[docArray firstObject]stringByAppendingString:@"/timeschedule.db"];
    //NSString *dbpath=[NSString stringWithFormat:@"%@/timeschedule.db",[docArray lastObject]];
    NSLog(@"%@",dbpath);
    
    return dbpath;
}

// method to execute insert,update and delete query
-(BOOL)executeQuery:(NSString *)query
{
    BOOL success=0;
    sqlite3_stmt *statement=NULL;
    const char *cQuery=[query UTF8String];
    const char *databaseFile=[[self getDatabasePath] UTF8String];
    if(sqlite3_open(databaseFile, &scheduleDatabase)==SQLITE_OK)
    {
        if(sqlite3_prepare_v2(scheduleDatabase, cQuery, -1, &statement, NULL)==SQLITE_OK)
        {
            if(sqlite3_step(statement)==SQLITE_DONE)
            {
                success=1;
                NSLog(@"Query Excecuted successfully");
            } else {
                NSLog(@"Error in sqlite step : %s",sqlite3_errmsg(scheduleDatabase));
            }
        } else {
            NSLog(@"Error in sqlite prepare : %s",sqlite3_errmsg(scheduleDatabase));
        }
    } else {
        NSLog(@"Error in sqlite open : %s",sqlite3_errmsg(scheduleDatabase));
    }
    sqlite3_finalize(statement);
    sqlite3_close(scheduleDatabase);

    return success;
    
}

// to get all table records
-(void)getAllRecords:(NSString *)query
{
    self.scheduleInfoArray=[[NSMutableArray alloc]init];
    [self.scheduleInfoArray removeAllObjects];
    
    sqlite3_stmt *statement=NULL;
    const char *cQuery=[query UTF8String];
    const char *databaseFile=[[self getDatabasePath]UTF8String];
    if(sqlite3_open(databaseFile, &scheduleDatabase)==SQLITE_OK)
    {
        if(sqlite3_prepare_v2(scheduleDatabase, cQuery, -1, &statement, NULL)==SQLITE_OK)
        {
            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                
                scheduleModel *obj=[[scheduleModel alloc]init];
                obj.scheduleName=[NSMutableString stringWithFormat:@"%s",sqlite3_column_text(statement, 0)] ;
                obj.roomName=[NSMutableString stringWithFormat:@"%s",sqlite3_column_text(statement, 1)];
                obj.applianceName=[NSMutableString stringWithFormat:@"%s",sqlite3_column_text(statement, 2)];
                obj.time=[NSMutableString stringWithFormat:@"%s",sqlite3_column_text(statement, 3)];
                obj.days=[NSMutableString stringWithFormat:@"%s",sqlite3_column_text(statement, 4)];
                
                [self.scheduleInfoArray addObject:obj];
                
            }
        } else {
            NSLog(@"Error in sqlite prepare : %s",sqlite3_errmsg(scheduleDatabase));
        }
    } else {
        NSLog(@"Error in sqlite open : %s",sqlite3_errmsg(scheduleDatabase));
    }
    sqlite3_finalize(statement);
    sqlite3_close(scheduleDatabase);

}


@end
