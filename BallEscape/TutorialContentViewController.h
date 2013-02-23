//
//  TutorialContentViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 16/12/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <UIKit/UIKit.h>

//  Show a secuence of images, teaching the user how to play game.
//
@interface TutorialContentViewController : UIViewController

@property (strong, nonatomic) id dataObject;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//  Skips the tutorial.
- (IBAction)skipTutorial:(UIButton *)sender;

@end
