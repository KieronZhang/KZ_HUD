//
//  HUDViewController.m
//  KZ_HUD_iOS
//
//  Created by Kieron Zhang on 2018/5/9.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "HUDViewController.h"
#import <KZ_HUD_iOS/UIView+KZ_HUD.h>

@interface HUDViewController ()

@end

@implementation HUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HUD";
    
    [KZ_HUDManager sharedManager].activityColor = [UIColor yellowColor];
    [KZ_HUDManager sharedManager].HUDColor = [UIColor redColor];
    [KZ_HUDManager sharedManager].contentColor = [UIColor greenColor];
    [KZ_HUDManager sharedManager].annularProgressLineWidth = 5.0f;
    [KZ_HUDManager sharedManager].annularProgressLineColor = [UIColor redColor];
    [KZ_HUDManager sharedManager].annularProgressColor = [UIColor greenColor];
    [KZ_HUDManager sharedManager].barProgressHeight = 30.0f;
    [KZ_HUDManager sharedManager].barProgressLineColor = [UIColor orangeColor];
    [KZ_HUDManager sharedManager].barProgressColor = [UIColor blueColor];
    [KZ_HUDManager sharedManager].barProgressLineWidth = 10.0f;
    
    HUDArray = @[@[@"Normal HUD", @"Normal HUD With Title", @"Normal HUD With Title And Content"], @[@"Progress HUD", @"Annular Progress HUD", @"Bar Progress HUD"], @[@"Text HUD", @"Text HUD With Content"], @[@"Custom HUD", @"Custom HUD With Content"], @[@"HUD With Action"], @[@"HUD Switch"]];
    
    HUDTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    HUDTableView.delegate = self;
    HUDTableView.dataSource = self;
    [self.view addSubview:HUDTableView];
}

- (void)updateHUDProgress:(NSNumber *)progress {
    if (progress.floatValue > 1) {
        [self.view hideHUD];
        return;
    }
    self.view.HUDProgress = progress.floatValue;
    [self performSelector:@selector(updateHUDProgress:) withObject:@(progress.floatValue + 0.01) afterDelay:0.05f];
}

- (void)switchProgressHUD {
    [self.view showProgressHUD:@"This is a Progress HUD" animated:NO];
    [self updateSwitchHUDProgress:@(0)];
}

- (void)updateSwitchHUDProgress:(NSNumber *)progress {
    if (progress.floatValue > 1) {
        [self.view showCustomHUD:@"This is a Custom HUD" customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]] animated:NO];
        [self.view performSelector:@selector(hideHUD) withObject:nil afterDelay:3.0f];
        return;
    }
    self.view.HUDProgress = progress.floatValue;
    [self performSelector:@selector(updateSwitchHUDProgress:) withObject:@(progress.floatValue + 0.01) afterDelay:0.05f];
}

- (void)actionHUDButton {
    [self.view hideHUD];
    NSLog(@"actionHUDButton");
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return HUDArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = HUDArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableViewCell = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCell];
    }
    cell.textLabel.text = HUDArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.view showHUD:nil animated:YES];
        }
        else if (indexPath.row == 1) {
            [self.view showHUD:@"This is an HUD With Title" animated:YES];
        }
        else if (indexPath.row == 2) {
            [self.view showHUD:@"This is an HUD With Title And Content" content:@"Parsing data\n(1/1)" animated:YES];
        }
        [self.view performSelector:@selector(hideHUD) withObject:nil afterDelay:3.0f];
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.view showProgressHUD:@"This is a Progress HUD" animated:YES];
            [self updateHUDProgress:@(0)];
        }
        else if (indexPath.row == 1) {
            [self.view showAnnularProgressHUD:@"This is an Annular Progress HUD" animated:YES];
            [self updateHUDProgress:@(0)];
        }
        else if (indexPath.row == 2) {
            [self.view showBarProgressHUD:@"This is a Bar Progress HUD" animated:YES];
            [self updateHUDProgress:@(0)];
        }
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self.view showTextHUD:@"This is a Text HUD" animated:YES];
        }
        else if (indexPath.row == 1) {
            [self.view showTextHUD:@"This is a Text HUD And Content" content:@"Parsing data\n(1/1)" animated:YES];
        }
        [self.view performSelector:@selector(hideHUD) withObject:nil afterDelay:3.0f];
    }
    else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [self.view showCustomHUD:@"This is a Custom HUD" customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]] animated:YES];
        }
        else if (indexPath.row == 1) {
            [self.view showCustomHUD:@"This is a Custom HUD" customView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]] content:@"Parsing data\n(1/1)" animated:YES];
        }
        [self.view performSelector:@selector(hideHUD) withObject:nil afterDelay:3.0f];
    }
    else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            [self.view showHUD:@"This is an HUD With Title" animated:YES];
            [self.view addHUDButtonWithTitle:@"Cancel" target:self action:@selector(actionHUDButton)];
        }
        [self.view performSelector:@selector(hideHUD) withObject:nil afterDelay:3.0f];
    }
    else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            [self.view showHUD:@"This is an HUD" animated:YES];
            [self performSelector:@selector(switchProgressHUD) withObject:nil afterDelay:3.0f];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
