//
//  HelloPolyViewController.m
//  HelloPoly
//
//  Created by Amelie on 14-1-23.
//  Copyright (c) 2014年 COMP41550. All rights reserved.
//

#import "HelloPolyViewController.h"



@implementation HelloPolyViewController

-(void)updateUI
{
    self.numberOfSidesLabel.text=[NSString stringWithFormat:@"%d",self.model.numberOfSides];
    self.polygonView.numberOfSides=self.model.numberOfSides;
    self.polygonView.name=self.model.name;
    //self.polygonView.name=self.polygonView.numberOfSides
    [self.numberOfSidesLabel sizeToFit];
    [self.polygonView setNeedsDisplay];
     NSLog(@"update %@",[NSString stringWithFormat:@"%d",self.model.numberOfSides]);

}




- (IBAction)increase:(UIButton *)sender {
    
    if ([sender isKindOfClass:[UISwipeGestureRecognizer class]])
    {
        NSLog(@"Swipe %@", ((UISwipeGestureRecognizer *)sender).direction == UISwipeGestureRecognizerDirectionLeft ? @"Left" : @"Right");
    }
    self.model.numberOfSides=self.model.numberOfSides+1;
    self.polygonView.numberOfSides=self.model.numberOfSides+1;
    [self updateUI];
    NSLog(@"increase %@",[NSString stringWithFormat:@"%d",self.model.numberOfSides]);
}

- (IBAction)decrease:(UIButton *)sender {
    if ([sender isKindOfClass:[UISwipeGestureRecognizer class]])
    {
        NSLog(@"Swipe %@", ((UISwipeGestureRecognizer *)sender).direction == UISwipeGestureRecognizerDirectionLeft ? @"Left" : @"Right");
    }
    self.model.numberOfSides=self.model.numberOfSides-1;
    self.polygonView.numberOfSides=self.model.numberOfSides-1;
    NSLog(@"decrease %@",[NSString stringWithFormat:@"%d",self.model.numberOfSides]);
    [self updateUI];
}




- (IBAction)rotationPholygon:(UIRotationGestureRecognizer *)sender {
    self.polygonView.center = self.view.center;
    /* Begin the animation */
    [UIView beginAnimations:@"clockwiseAnimation" context:NULL];
    /* Make the animation 5 seconds long */
    [UIView setAnimationDuration:5.0f];
    [UIView setAnimationDelegate:self];
    //停止动画时候调用clockwiseRotationStopped方法
    [UIView setAnimationDidStopSelector:@selector(clockwiseRotationStopped:finished:context:)];
    //顺时针旋转90度
    self.polygonView.transform = CGAffineTransformMakeRotation((90.0f * M_PI) / 180.0f);
    /* Commit the animation */
    [UIView commitAnimations];
}

- (IBAction)swipeDown:(UISwipeGestureRecognizer *)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: UIViewAnimationTransitionCurlDown forView:self.polygonView cache:YES];
    self.model.numberOfSides=self.model.numberOfSides-1;
    self.polygonView.numberOfSides=self.model.numberOfSides-1;
    NSLog(@"decrease %@",[NSString stringWithFormat:@"%d",self.model.numberOfSides]);
    [self updateUI];

    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];
}

- (void) animationFinished: (id) sender{
    NSLog(@"animationFinished !");
}
- (IBAction)decreaseSwipeLeft:(UISwipeGestureRecognizer *)sender {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition: UIViewAnimationTransitionCurlUp forView:self.polygonView  cache:YES];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    [UIView commitAnimations];

    self.model.numberOfSides=self.model.numberOfSides+1;
    self.polygonView.numberOfSides=self.model.numberOfSides+1;
    [self updateUI];
    NSLog(@"increase %@",[NSString stringWithFormat:@"%d",self.model.numberOfSides]);
}
- (IBAction)increaseSwipeRight:(UISwipeGestureRecognizer *)sender {
    self.polygonView.center = self.view.center;
    [UIView beginAnimations:@"clockwiseAnimation" context:NULL];
    [UIView setAnimationDuration:5.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(clockwiseRotationStopped:finished:context:)];
    self.polygonView.transform = CGAffineTransformMakeRotation((90.0f * M_PI) / 180.0f);
    [UIView commitAnimations];

}

- (void)clockwiseRotationStopped:(NSString *)paramAnimationID finished:(NSNumber *)paramFinished
                         context:(void *)paramContext{
    [UIView beginAnimations:@"counterclockwiseAnimation"context:NULL];
    [UIView setAnimationDuration:5.0f];
    self.polygonView.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}


- (void)viewDidUnload {
    self.model.numberOfSides=[self.numberOfSidesLabel.text integerValue];
    self.polygonView.numberOfSides=self.model.numberOfSides;
    NSLog(@"viewdid %@",[NSString stringWithFormat:@"%d",self.polygonView.numberOfSides]);
self.polygonView.name=self.model.name;
    [super viewDidLoad];
     //[self.polygonView setNeedsDisplay];

    [self updateUI];
   }

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.polygonView.numberOfSides=self.model.numberOfSides;
	// Do any additional setup after loading the view, typically from a nib.
    // self.polygonView.delegate = self;
    //self.polygonView.name=@"triangle";
    self.polygonView.name=self.model.name;

    [self updateUI];
}
//- (void)awakeFromNib
//{
   // NSLog(@"My polygon: %@", self.model.name);
// my internal stuff here
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RotationPolygon:(id)sender {
}
@end
