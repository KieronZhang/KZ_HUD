//
//  HUDViewController.h
//  KZ_HUD_iOS
//
//  Created by Kieron Zhang on 2018/5/9.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *HUDTableView;
    NSArray *HUDArray;
}

@end
