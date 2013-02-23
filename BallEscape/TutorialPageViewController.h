//
//  TutorialPageViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 16/12/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialContentViewController.h"

//  Class with the content of a page controller.
//  This class has an array with all the images to be shown.
//
@interface TutorialPageViewController : UIViewController < UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageContent;

@end
