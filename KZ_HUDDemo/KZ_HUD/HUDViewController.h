//
//  HUDViewController.h
//  KZ_HUD
//
//  Created by Kieron Zhang on 2017/12/12.
//  Copyright © 2017年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *HUDTableView;
    NSArray *HUDArray;
}

@end
