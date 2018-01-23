//
//  ViewController.h
//  KZ_HUD
//
//  Created by Kieron Zhang on 2017/12/7.
//  Copyright © 2017年 Kieron Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UITableView *toastTableView;
    NSArray *toastArray;
}

@end
