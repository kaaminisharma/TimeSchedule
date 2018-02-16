//
//  addScheduleViewController.m
//  TimeSchedule
//
//  Created by Kamini Sharma on 13/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import "addScheduleViewController.h"
#import "TypeApplianceTableViewController.h"
#import "scheduleDB.h"
#import "scheduleModel.h"

@interface addScheduleViewController ()

@end

@implementation addScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.daysArray=[[NSMutableArray alloc]init];
    
    self.roomBtn.tag=1;
    self.applianceBtn.tag=2;
    
    // to circle week days button
    NSInteger btnRadius=15;
    self.sunBtn.layer.cornerRadius=btnRadius;
    self.monBtn.layer.cornerRadius=btnRadius;
    self.tueBtn.layer.cornerRadius=btnRadius;
    self.wedBtn.layer.cornerRadius=btnRadius;
    self.thuBtn.layer.cornerRadius=btnRadius;
    self.friBtn.layer.cornerRadius=btnRadius;
    self.satBtn.layer.cornerRadius=btnRadius;
    

    if(self.flag)
    {
        [self.daysArray removeAllObjects];
        
        NSString *getQuery=[NSString stringWithFormat:@"select * from schedule where scheduleName='%@'",self.schName];
        [[scheduleDB getSharedObject] getAllRecords:getQuery];
        scheduleModel *sObj=[[[scheduleDB getSharedObject] scheduleInfoArray] objectAtIndex:0];
        
        self.scheduleNameTxt.enabled=NO;
        [self.updateBtn setTitle:@"UPDATE" forState:UIControlStateNormal];
        
        self.scheduleNameTxt.text=sObj.scheduleName;
        self.roomTypeTxt.text=sObj.roomName;
        self.applianceTxt.text=sObj.applianceName;
        
        NSDateFormatter *timeFormat=[[NSDateFormatter alloc]init];
        [timeFormat setDateFormat:@"hh:mm a"];
        NSDate *covertTimeForDatePicker=[timeFormat dateFromString:sObj.time];
        self.timePick.date=covertTimeForDatePicker;
        
        self.daysString=sObj.days;
        
        // spliting days string into array to show button selected when editing schedule
        self.daysArray=[sObj.days componentsSeparatedByString: @","];
        [self showDaysSelected:self.daysArray]; // calling function to show days button selected
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = [UIColor Your Customcolor];
    }
    
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

- (IBAction)clickBtn:(UIButton *)sender {
    
    // to change the selected/highlighted default color, change the button property.. UIButton 'type' was set to 'System', changed it to 'Custom',
    sender.selected  = ! sender.selected;

    NSString *str=sender.titleLabel.text;
    if (sender.selected)
    {
        sender.backgroundColor=[UIColor orangeColor];
        sender.tintColor=[UIColor whiteColor];
        [self.daysArray addObject:str];
    }
    else
    {
        sender.backgroundColor=[UIColor lightGrayColor];
        sender.tintColor=[UIColor blackColor];
        [self.daysArray removeObject:str];
    }
    
    //NSSortDescriptor *valueDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:NO];
    //[self.daysArray sortedArrayUsingDescriptors:@[valueDescriptor]];
    
    //[self.daysArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    // if all days selected
    if(_daysArray.count==7)
    {
        self.daysString=@"EVERYDAY";
    }else{
       self.daysString=[self.daysArray componentsJoinedByString:@","];
    }
    
}

-(void)showDaysSelected:(NSArray *)selectedDaysArray
{
   for(NSString *str in selectedDaysArray)
   {
       if([str isEqualToString:self.sunBtn.titleLabel.text])
       {
         self.sunBtn.backgroundColor=[UIColor orangeColor];
         self.sunBtn.selected=true;
           
       } else if([str isEqualToString:self.monBtn.titleLabel.text])
       {
           self.monBtn.backgroundColor=[UIColor orangeColor];
           self.monBtn.selected=true;
           
       } else if([str isEqualToString:self.tueBtn.titleLabel.text])
       {
           self.tueBtn.backgroundColor=[UIColor orangeColor];
           self.tueBtn.selected=true;
           
       } else if([str isEqualToString:self.wedBtn.titleLabel.text])
       {
           self.wedBtn.backgroundColor=[UIColor orangeColor];
           self.wedBtn.selected=true;
           
       } else if([str isEqualToString:self.thuBtn.titleLabel.text])
       {
           self.thuBtn.backgroundColor=[UIColor orangeColor];
           self.thuBtn.selected=true;
           
       } else if([str isEqualToString:self.friBtn.titleLabel.text])
       {
           self.friBtn.backgroundColor=[UIColor orangeColor];
           self.friBtn.selected=true;
           
       } else //if([str isEqualToString:self.satBtn.titleLabel.text])
       {
           self.satBtn.backgroundColor=[UIColor orangeColor];
           self.satBtn.selected=true;
       }
   }
}

- (IBAction)updateClick:(id)sender {
    
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"hh:mm a"];
    NSString *timeResult = [format stringFromDate: self.timePick.date];
    
    if(self.flag) // for updating record
    {
        
        NSString *updateQuery=[NSString stringWithFormat:@"update schedule set roomType='%@',applianceType='%@',time='%@',days='%@' where scheduleName='%@' ",_roomTypeTxt.text,_applianceTxt.text,timeResult,_daysString,_scheduleNameTxt.text];
        
        BOOL success=[[scheduleDB getSharedObject] executeQuery:updateQuery];
        if(success)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Schedule Updated Successfully!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                 {
                                    [self.navigationController popViewControllerAnimated:YES];
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            NSLog(@"Error in executing query");
        }
    
    } else { // for inserting new record
        
        NSString *saveQuery=[NSString stringWithFormat:@"insert into schedule(scheduleName,roomType,applianceType,time,days) values('%@','%@','%@','%@','%@')",_scheduleNameTxt.text,_roomTypeTxt.text,_applianceTxt.text,timeResult,_daysString];
        
        BOOL success=[[scheduleDB getSharedObject] executeQuery:saveQuery];
        if(success)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Schedule Added Successfully!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                 {
                                     [self.navigationController popViewControllerAnimated:YES];
                                 }];
            
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            NSLog(@"Error in executing query");
        }
        
    }
    
}

- (IBAction)getRoomApplianceType:(UIButton *)sender {
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    TypeApplianceTableViewController *tavc=[story instantiateViewControllerWithIdentifier:@"TypeApplianceTableViewController"];
    
    // calling delegate
    tavc.delegate=self;
    
    // button tags
    if(sender.tag==1)
    {
        tavc.buttonType=@"Roomtype";
    }
    if(sender.tag==2)
    {
        tavc.buttonType=@"ApplianceType";
    }

    [self.navigationController pushViewController:tavc animated:YES];
    
}

// custom delegate's function definition to get the data and show it in particular place
-(void)getRoomTypeData:(NSString *)data
{
    self.roomTypeTxt.text=data;
}

-(void)getRoomApplianceData:(NSString *)data
{
    self.applianceTxt.text=data;
}


- (IBAction)deleteBtnClick:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"DELETE SCHEDULE" message:@"Are you sure to delete?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                         {
                             NSString *deleteQuery=[NSString stringWithFormat:@"delete from schedule where scheduleName='%@' ",self.scheduleNameTxt.text];
                             
                             BOOL success=[[scheduleDB getSharedObject] executeQuery:deleteQuery];
                             if(success)
                             {
                                 [self.navigationController popViewControllerAnimated:YES];
                             } else {
                                 NSLog(@"Error in executing query");
                             }
                             
                         }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    

}
@end
