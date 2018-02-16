//
//  ScheduleViewController.m
//  TimeSchedule
//
//  Created by Kamini Sharma on 13/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import "ScheduleViewController.h"
#import <sqlite3.h>
#import "scheduleDB.h"
#import "scheduleModel.h"
#import "customScheduleTableViewCell.h"
#import "addScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.allScheduleTable.delegate=self;
    self.allScheduleTable.dataSource=self;
    
    [self.allScheduleTable registerNib:[UINib nibWithNibName:@"customScheduleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    NSString *getQuery=@"select * from schedule";
    [[scheduleDB getSharedObject] getAllRecords:getQuery];
    
    self.addBtn.layer.cornerRadius=20;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *getQuery=@"select * from schedule";
    [[scheduleDB getSharedObject] getAllRecords:getQuery];
    [self.allScheduleTable reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger arrcount=[[scheduleDB getSharedObject] scheduleInfoArray].count;
    return arrcount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    customScheduleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    scheduleModel *sObj=[[[scheduleDB getSharedObject] scheduleInfoArray] objectAtIndex:indexPath.row];
    
    cell.scheduleNameLbl.text=[NSString stringWithFormat:@"%@",sObj.scheduleName];
    cell.timeLbl.text=[NSString stringWithFormat:@"%@",sObj.time];
    cell.daysLbl.text=[NSString stringWithFormat:@"%@",sObj.days];
    
    cell.layer.cornerRadius = 20;
    
    cell.layer.shadowOffset = CGSizeMake(1, 0);
    cell.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    cell.layer.shadowRadius = 8;
    cell.layer.shadowOpacity = .55f;
    CGRect shadowFrame = cell.layer.bounds;
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    cell.layer.shadowPath = shadowPath;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    addScheduleViewController *asvc=[story instantiateViewControllerWithIdentifier:@"addScheduleViewController"];
    
    scheduleModel *sObj=[[[scheduleDB getSharedObject] scheduleInfoArray] objectAtIndex:indexPath.row];
    
    asvc.schName=sObj.scheduleName;
    asvc.flag=1;
    
    [self.navigationController pushViewController:asvc animated:YES];
    
}

/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
    
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
