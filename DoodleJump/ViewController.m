//
//  ViewController.m
//  DoodleJump
//
//  Created by luowei on 14-6-10.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "ViewController.h"

int highScoreNumber;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *highScore;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    highScoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScoreNumber"];
    _highScore.text = [NSString stringWithFormat:@"最高得分:%i",highScoreNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
