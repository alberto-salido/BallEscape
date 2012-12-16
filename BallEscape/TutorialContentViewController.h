//
//  TutorialContentViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 16/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialContentViewController : UIViewController

@property (strong, nonatomic) id dataObject;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)skipTutorial:(UIButton *)sender;

@end
