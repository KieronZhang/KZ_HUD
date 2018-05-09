//
//  ViewController.m
//  KZ_HUD_iOS
//
//  Created by Kieron Zhang on 2018/5/9.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "ViewController.h"
#import "HUDViewController.h"
#import <KZ_HUD_iOS/UIView+KZ_Toast.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-retain-self"

@interface ViewController ()

@property (nonatomic, assign) KZ_ToastPosition position;
@property (nonatomic, assign) KZ_ToastQueueType queueType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Toast";
    self.position = KZ_ToastPosition_Center;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"HUD" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemTapped)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    toastArray = @[@[@"Position", @"Queue Type"], @[@"Normal Toast", @"Normal Toast With Title", @"Normal Toast With Image", @"Normal Toast With Title And Image", @"Normal Toast With Completion", @"Hide All Toast"]];
    
    toastTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    toastTableView.delegate = self;
    toastTableView.dataSource = self;
    [self.view addSubview:toastTableView];
}

- (void)rightItemTapped {
    HUDViewController *viewController = [[HUDViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return toastArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = toastArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableViewCell = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableViewCell];
    }
    cell.textLabel.text = toastArray[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = @"";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (self.position == KZ_ToastPosition_Top) {
                cell.detailTextLabel.text = @"上";
            }
            else if (self.position == KZ_ToastPosition_Center) {
                cell.detailTextLabel.text = @"中";
            }
            else if (self.position == KZ_ToastPosition_Bottom) {
                cell.detailTextLabel.text = @"下";
            }
        }
        else if (indexPath.row == 1) {
            if (self.queueType == KZ_ToastQueueType_Normal) {
                cell.detailTextLabel.text = @"Normal";
            }
            else if (self.queueType == KZ_ToastQueueType_Queue) {
                cell.detailTextLabel.text = @"Queue";
            }
            else if (self.queueType == KZ_ToastQueueType_Cover) {
                cell.detailTextLabel.text = @"Cover";
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择Toast位置" preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"上" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.position = KZ_ToastPosition_Top;
                [toastTableView reloadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"中" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.position = KZ_ToastPosition_Center;
                [toastTableView reloadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"下" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.position = KZ_ToastPosition_Bottom;
                [toastTableView reloadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (indexPath.row == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"选择Toast方式" preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Normal" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.queueType = KZ_ToastQueueType_Normal;
                [toastTableView reloadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Queue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.queueType = KZ_ToastQueueType_Queue;
                [toastTableView reloadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cover" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.queueType = KZ_ToastQueueType_Cover;
                [toastTableView reloadData];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    else if (indexPath.section == 1) {
        [KZ_ToastManager sharedManager].defaultQueueType = self.queueType;
        if (indexPath.row == 0) {
            [self.view showToast:@"This is Toast Test" duration:2.0f position:self.position];
        }
        if (indexPath.row == 1) {
            [self.view showToast:@"This is Toast Test With Toast Title" title:@"Toast Title" image:nil duration:2.0f position:self.position];
        }
        else if (indexPath.row == 2) {
            [self.view showToast:@"This is Toast Test With Toast Image" title:nil image:[UIImage imageNamed:@"logo"] duration:2.0f position:self.position];
        }
        else if (indexPath.row == 3) {
            [self.view showToast:@"This is Toast Test With Toast Title And Toast Image" title:@"Toast Title" image:[UIImage imageNamed:@"logo"] duration:2.0f position:self.position];
        }
        else if (indexPath.row == 4) {
            [self.view showToast:@"This is Toast Test With Completion" duration:2.0f position:self.position completion:^(BOOL tapped) {
                NSLog(@"completion");
            }];
        }
        else if (indexPath.row == 5) {
            [self.view hideAllToast];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma clang diagnostic pop

@end
