//
//  Game.m
//  DoodleJump
//
//  Created by luowei on 14-6-10.
//  Copyright (c) 2014年 rootls. All rights reserved.
//

#import "Game.h"

float upMovement;
float sideMovement;
int randomPosition;
int platform3SideMovement;
int platform5SideMovement;

BOOL ballLeft;
BOOL ballRight;
BOOL stopSideMovement;

@interface Game (){
    NSTimer *movement;
}
@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIImageView *platform1;
@property (weak, nonatomic) IBOutlet UIImageView *platform2;
@property (weak, nonatomic) IBOutlet UIImageView *platform3;
@property (weak, nonatomic) IBOutlet UIImageView *platform4;
@property (weak, nonatomic) IBOutlet UIImageView *platform5;

@end

@implementation Game

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    ballLeft = NO;
    ballRight = NO;
    stopSideMovement = YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if(point.x < 140){
        ballLeft = YES;
    }else{
        ballRight = YES;
    }
}

-(void)platformMovement{
    _platform3.center = CGPointMake(_platform3.center.x + platform3SideMovement, _platform3.center.y);
    _platform5.center = CGPointMake(_platform5.center.x + platform5SideMovement, _platform5.center.y);
    
    if(_platform3.center.x < 37){
        platform3SideMovement = 2;
    }
    if(_platform3.center.x > 283){
        platform3SideMovement = -2;
    }
    if(_platform5.center.x < 37){
        platform5SideMovement = 2;
    }
    if(_platform5.center.x > 283){
        platform5SideMovement = -2;
    }
    
}

-(void)moving{
    [self platformMovement];
    
    _ball.center = CGPointMake(_ball.center.x + sideMovement, _ball.center.y - upMovement);
    if(CGRectIntersectsRect(_ball.frame, _platform1.frame) && upMovement < -2){
        [self bounce];
    }
    upMovement -= 0.1;
    
    if(ballLeft == YES){
        sideMovement -= 0.3;
        if(sideMovement < -5){
            sideMovement = -5;
        }
    }
    if(ballRight == YES){
        sideMovement += 0.3;
        if(sideMovement > 5){
            sideMovement = 5;
        }
    }
    
    if(stopSideMovement == YES && sideMovement > 0){
        sideMovement -= 0.1;
        if(sideMovement < 0){
            sideMovement = 0;
            stopSideMovement = NO;
        }
    }
    if(stopSideMovement == YES && sideMovement < 0){
        sideMovement += 0.1;
        if(sideMovement > 0){
            sideMovement = 0;
            stopSideMovement = NO;
        }
    }
    
    //超出屏幕左边框时从右边框出来，超出屏幕右边框时从左边框出来
    if(_ball.center.x < -11){
        _ball.center = CGPointMake(330, _ball.center.y);
    }
    if(_ball.center.x > 330){
        _ball.center = CGPointMake(-11, _ball.center.y);
    }
}

-(void)bounce{
    _ball.animationImages = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"ballBounce1.png"],
                             [UIImage imageNamed:@"ballBounce2.png"],
                             [UIImage imageNamed:@"ballBounce1.png"],
                             [UIImage imageNamed:@"ball.png"],nil];
    [_ball setAnimationRepeatCount:1];
    _ball.animationDuration = 0.2;
    [_ball startAnimating];
    
    upMovement = 5;
}

- (IBAction)startGame:(id)sender {
    _start.hidden = YES;
    upMovement = -5;
    
    movement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(moving) userInfo:nil repeats:YES];
    
    _platform2.hidden = NO;
    _platform3.hidden = NO;
    _platform4.hidden = NO;
    _platform5.hidden = NO;
    
    randomPosition = arc4random() % 248;
    randomPosition += 36;
    _platform2.center = CGPointMake(randomPosition, 448);
    
    randomPosition = arc4random() % 248;
    randomPosition += 36;
    _platform3.center = CGPointMake(randomPosition, 336);
    
    randomPosition = arc4random() % 248;
    randomPosition += 36;
    _platform4.center = CGPointMake(randomPosition, 224);
    
    randomPosition = arc4random() % 248;
    randomPosition += 36;
    _platform5.center = CGPointMake(randomPosition, 112);
    
    platform3SideMovement = -2;
    platform5SideMovement = 2;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _platform2.hidden = YES;
    _platform3.hidden = YES;
    _platform4.hidden = YES;
    _platform5.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
