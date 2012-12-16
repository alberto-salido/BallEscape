//
//  TutorialPageViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 16/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialContentViewController.h"

@interface TutorialPageViewController : UIViewController < UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageContent;

@end
