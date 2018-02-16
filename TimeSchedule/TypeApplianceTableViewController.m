//
//  TypeApplianceTableViewController.m
//  TimeSchedule
//
//  Created by Kamini Sharma on 20/01/18.
//  Copyright © 2018 Kamini Sharma. All rights reserved.
//

#import "TypeApplianceTableViewController.h"

@interface TypeApplianceTableViewController ()

@end

@implementation TypeApplianceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.roomType=[[NSMutableArray alloc]initWithObjects:@"Bedroom",@"Living room",@"Dining room",@"Kitchen"
                   , nil];
    self.roomAppliance=[[NSMutableArray alloc]initWithObjects:@"Light1",@"Light2",@"Light3",@"Fan"
                        , nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger num=0;
    if([self.buttonType isEqualToString:@"Roomtype"])
    {
        num=self.roomType.count;
    }
    if([self.buttonType isEqualToString:@"ApplianceType"])
    {
        num=self.roomAppliance.count;
    }
    return num;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if([self.buttonType isEqualToString:@"Roomtype"])
    {
        cell.textLabel.text=[self.roomType objectAtIndex:indexPath.row];
    }
    if([self.buttonType isEqualToString:@"ApplianceType"])
    {
        cell.textLabel.text=[self.roomAppliance objectAtIndex:indexPath.row];
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([self.buttonType isEqualToString:@"Roomtype"])
    {
        // calling delegate function and sendng data to the function
        [self.delegate getRoomTypeData:[self.roomType objectAtIndex:indexPath.row]];
    }
    if([self.buttonType isEqualToString:@"ApplianceType"])
    {
        [self.delegate getRoomApplianceData:[self.roomAppliance objectAtIndex:indexPath.row]];
    }
    // sending control back to previous view controller
    [self.navigationController popViewControllerAnimated:YES];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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
