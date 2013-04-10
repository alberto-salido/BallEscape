//
//  TutorialPageViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 16/12/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "TutorialPageViewController.h"

//  Constants with he number of pages of the tutorial, and the name of each one of
//  these images. The image name format is 'tutorialPage' plus an integer with the
//  page number.
static int const NUM_OF_PAGES = 3;
static NSString *const IMAGE_NAME = @"tutorialPage";

@interface TutorialPageViewController ()

- (void)createContentPages;
- (TutorialContentViewController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(TutorialContentViewController *)viewController;

@end

@implementation TutorialPageViewController

@synthesize pageViewController = _pageViewController;
@synthesize pageContent = _pageContent;


#pragma mark - View lifecycle

- (void)viewDidUnload
{
    self.pageViewController = nil;
    self.pageContent = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createContentPages];
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                        forKey: UIPageViewControllerOptionSpineLocationKey];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
    
    self.pageViewController.dataSource = self;
    [[self.pageViewController view] setFrame:[[self view] bounds]];
    
    TutorialContentViewController *initialViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [[self view] addSubview:[self.pageViewController view]];
    [self.pageViewController didMoveToParentViewController:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

#pragma mark - Auxiliar

- (void)createContentPages
{
    NSMutableArray *pageImages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < NUM_OF_PAGES; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@%d.bmp", IMAGE_NAME, i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [pageImages addObject:image];
        }
    }
    self.pageContent = [[NSArray alloc] initWithArray:pageImages];
}

- (TutorialContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count])) {
        return nil;
    }
    
    TutorialContentViewController *dataViewController;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIStoryboard *storyboard =
        [UIStoryboard storyboardWithName:@"iPad" bundle:[NSBundle mainBundle]];
        
        dataViewController =
        [storyboard instantiateViewControllerWithIdentifier:@"contentView"];

    } else {
        UIStoryboard *storyboard =
        [UIStoryboard storyboardWithName:@"iPhone" bundle:[NSBundle mainBundle]];
        
        dataViewController =
        [storyboard instantiateViewControllerWithIdentifier:@"contentView"];

    }
        
    dataViewController.dataObject = [self.pageContent objectAtIndex:index];
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(TutorialContentViewController *)viewController
{
    return [self.pageContent indexOfObject:viewController.dataObject];
}

#pragma mark - UIPageViewControllerDataSource Protocol

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(TutorialContentViewController *)viewController];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index --;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(TutorialContentViewController *)viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index ++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

@end
