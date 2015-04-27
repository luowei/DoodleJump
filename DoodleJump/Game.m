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

float platformMoveDown;

int scoreNumber;
int highScoreNumber;
int addedScore;
int levelNumber;

BOOL platform1Used;
BOOL platform2Used;
BOOL platform3Used;
BOOL platform4Used;
BOOL platform5Used;

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

@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *gameOver;
@property (weak, nonatomic) IBOutlet UILabel *finalScore;
@property (weak, nonatomic) IBOutlet UILabel *highScore;
@property (weak, nonatomic) IBOutlet UIButton *exit;

@end

@implementation Game

-(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

-(CGFloat)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}

-(void)scoring{
    scoreNumber = scoreNumber + addedScore;
    addedScore -= 1;
    if(addedScore < 0){
        addedScore = 0;
    }
    _score.text = [NSString stringWithFormat:@"%i",scoreNumber];
    if(scoreNumber > 500 && scoreNumber < 1000){
        levelNumber = 2;
    }
    if(scoreNumber > 10000 && scoreNumber < 2000){
        levelNumber = 3;
    }
    if(scoreNumber > 2000 && scoreNumber < 3000){
        levelNumber = 4;
    }
    if(scoreNumber > 3000 && scoreNumber < 4000){
        levelNumber = 5;
    }
    if(scoreNumber > 4000 && scoreNumber < 5000){
        levelNumber = 6;
    }
}

-(void)gameOv{
    _ball.hidden = YES;
    _platform1.hidden = YES;
    _platform2.hidden = YES;
    _platform3.hidden = YES;
    _platform4.hidden = YES;
    _platform5.hidden = YES;
    _score.hidden = YES;
    _gameOver.hidden = NO;
    _exit.hidden = NO;
    _finalScore.hidden = NO;
    _finalScore.text = [NSString stringWithFormat:@"最终得分:%i",scoreNumber];
    [movement invalidate];
    
    if(scoreNumber > highScoreNumber){
        highScoreNumber = scoreNumber;
        [[NSUserDefaults standardUserDefaults]setInteger:highScoreNumber forKey:@"highScoreNumber"];
    }
}

-(void)platformFall{
    if(_ball.center.y > self.screenHeight*5/6){
        platformMoveDown = 1;
    }else if(_ball.center.y > self.screenHeight*4/6){
        platformMoveDown = 2;
    }else if(_ball.center.y > self.screenHeight*3/6){
        platformMoveDown = 4;
    }else if(_ball.center.y > self.screenHeight*2/6){
        platformMoveDown = 5;
    }else if(_ball.center.y >self.screenHeight*1/6){
        platformMoveDown = 6;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    ballLeft = NO;
    ballRight = NO;
    stopSideMovement = YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if(point.x < self.screenWidth/2){
        ballLeft = YES;
    }else{
        ballRight = YES;
    }
}

-(void)platformMovement{
    _platform1.center = CGPointMake(_platform1.center.x, _platform1.center.y + platformMoveDown);
    _platform2.center = CGPointMake(_platform2.center.x, _platform2.center.y + platformMoveDown);
    _platform3.center = CGPointMake(_platform3.center.x + platform3SideMovement, _platform3.center.y+platformMoveDown);
    _platform4.center = CGPointMake(_platform4.center.x, _platform4.center.y + platformMoveDown);
    _platform5.center = CGPointMake(_platform5.center.x + platform5SideMovement, _platform5.center.y+platformMoveDown);

    CGFloat platWidth = _platform1.frame.size.width;

    if(_platform3.center.x < platWidth/2){
        switch (levelNumber) {
            case 1:
                platform3SideMovement = 2;
                break;
            case 2:
                platform3SideMovement = 3;
                break;
            case 3:
                platform3SideMovement = 4;
                break;
            case 4:
                platform3SideMovement = 5;
                break;
            case 5:
                platform3SideMovement = 6;
                break;
            case 6:
                platform3SideMovement = 7;
                break;
            default:
                break;
        }
    }
    if(_platform3.center.x > self.screenWidth-platWidth/2){
        switch (levelNumber) {
            case 1:
                platform3SideMovement = -2;
                break;
            case 2:
                platform3SideMovement = -3;
                break;
            case 3:
                platform3SideMovement = -4;
                break;
            case 4:
                platform3SideMovement = -5;
                break;
            case 5:
                platform3SideMovement = -6;
                break;
            case 6:
                platform3SideMovement = -7;
                break;
            default:
                break;
        }
    }
    if(_platform5.center.x < platWidth/2){
        switch (levelNumber) {
            case 1:
                platform5SideMovement = 2;
                break;
            case 2:
                platform5SideMovement = 3;
                break;
            case 3:
                platform5SideMovement = 4;
                break;
            case 4:
                platform5SideMovement = 5;
                break;
            case 5:
                platform5SideMovement = 6;
                break;
            case 6:
                platform5SideMovement = 7;
                break;
            default:
                break;
        }
    }
    if(_platform5.center.x > self.screenWidth-platWidth/2){
        switch (levelNumber) {
            case 1:
                platform5SideMovement = -2;
                break;
            case 2:
                platform5SideMovement = -3;
                break;
            case 3:
                platform5SideMovement = -4;
                break;
            case 4:
                platform5SideMovement = -5;
                break;
            case 5:
                platform5SideMovement = -6;
                break;
            case 6:
                platform5SideMovement = -7;
                break;
            default:
                break;
        }
    }
    
    platformMoveDown -= 0.1;
    
    if(platformMoveDown < 0){
        platformMoveDown = 0;
    }

    CGFloat platHeight = _platform1.frame.size.height;
    int platWidthBounds = lrintf(self.screenWidth-platWidth/2);

    if(_platform1.center.y > self.screenHeight-platHeight/2){
        randomPosition = arc4random() % platWidthBounds;
        randomPosition += (platWidth/2);
        _platform1.center = CGPointMake(randomPosition, -platHeight/2);
        platform1Used = NO;
    }
    if(_platform2.center.y > self.screenHeight-platHeight/2){
        randomPosition = arc4random() % platWidthBounds;
        randomPosition += (platWidth/2);
        _platform2.center = CGPointMake(randomPosition, -platHeight/2);
        platform2Used = NO;
    }
    if(_platform3.center.y > self.screenHeight-platHeight/2){
        randomPosition = arc4random() % platWidthBounds;
        randomPosition += (platWidth/2);
        _platform3.center = CGPointMake(randomPosition, -platHeight/2);
        platform3Used = NO;
    }
    if(_platform4.center.y > self.screenHeight-platHeight/2){
        randomPosition = arc4random() % platWidthBounds;
        randomPosition += (platWidth/2);
        _platform4.center = CGPointMake(randomPosition, -platHeight/2);
        platform4Used = NO;
    }
    if(_platform5.center.y > self.screenHeight-platHeight/2){
        randomPosition = arc4random() % platWidthBounds;
        randomPosition += (platWidth/2);
        _platform5.center = CGPointMake(randomPosition, -platHeight/2);
        platform5Used = NO;
    }
    
    
}

-(void)moving{
    if(_ball.center.y > self.screenHeight){
        [self gameOv];
    }
    
    [self scoring];
    
    if(_ball.center.y < 250){
        _ball.center = CGPointMake(_ball.center.x, 250);
    }
    
    [self platformMovement];
    
    _ball.center = CGPointMake(_ball.center.x + sideMovement, _ball.center.y - upMovement);
    if(CGRectIntersectsRect(_ball.frame, _platform1.frame) && upMovement < -2){
        [self bounce];
        [self platformFall];
        if(platform1Used == NO){
            addedScore = 10;
            platform1Used = YES;
        }
    }
    if (CGRectIntersectsRect(_ball.frame, _platform2.frame) && upMovement < -2){
        [self bounce];
        [self platformFall];
        if(platform2Used == NO){
            addedScore = 10;
            platform2Used = YES;
        }
    }
    if(CGRectIntersectsRect(_ball.frame, _platform3.frame) && upMovement < -2){
        [self bounce];
        [self platformFall];
        if(platform3Used == NO){
            addedScore = 10;
            platform3Used = YES;
        }
    }
    if(CGRectIntersectsRect(_ball.frame, _platform4.frame) && upMovement < -2){
        [self bounce];
        [self platformFall];
        if(platform4Used == NO){
            addedScore = 10;
            platform4Used = YES;
        }
    }
    if(CGRectIntersectsRect(_ball.frame, _platform5.frame) && upMovement < -2){
        [self bounce];
        [self platformFall];
        if(platform5Used == NO){
            addedScore = 10;
            platform5Used = YES;
        }
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
    CGFloat ballWidth = _ball.frame.size.width;
    if(_ball.center.x < -ballWidth/2){
        _ball.center = CGPointMake(self.screenWidth+ballWidth/2, _ball.center.y);
    }
    if(_ball.center.x > self.screenWidth+ballWidth/2){
        _ball.center = CGPointMake(-ballWidth/2, _ball.center.y);
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
    
    if(_ball.center.y > self.screenHeight*0.75){
        upMovement = 6;
    }else if(_ball.center.y > self.screenHeight*0.5){
        upMovement = 5;
    }else if(_ball.center.y > self.screenHeight*0.25){
        upMovement = 4;
    }
}

- (IBAction)startGame:(id)sender {
    _start.hidden = YES;
    upMovement = -5;
    
    movement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(moving) userInfo:nil repeats:YES];
    
    _platform2.hidden = NO;
    _platform3.hidden = NO;
    _platform4.hidden = NO;
    _platform5.hidden = NO;

    CGFloat platWidth = _platform2.frame.size.width;
    int platWidthBounds = lrintf(self.screenWidth-platWidth/2);
    
    randomPosition = arc4random() % platWidthBounds;
    randomPosition += (platWidth/2);
    _platform2.center = CGPointMake(randomPosition, self.screenHeight*4/5);
    
    randomPosition = arc4random() % platWidthBounds;
    randomPosition += (platWidth/2);
    _platform3.center = CGPointMake(randomPosition, self.screenHeight*3/5);
    
    randomPosition = arc4random() % platWidthBounds;
    randomPosition += (platWidth/2);
    _platform4.center = CGPointMake(randomPosition, self.screenHeight*2/5);
    
    randomPosition = arc4random() % platWidthBounds;
    randomPosition += (platWidth/2);
    _platform5.center = CGPointMake(randomPosition, self.screenHeight*1/5);

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
    _platform2.hidden = YES;
    _platform3.hidden = YES;
    _platform4.hidden = YES;
    _platform5.hidden = YES;
    
    _gameOver.hidden = YES;
    _finalScore.hidden = YES;
    _highScore.hidden = YES;
    _exit.hidden = YES;
    
    scoreNumber = 0;
    addedScore = 0;
    levelNumber = 1;
    
    platform1Used = NO;
    platform2Used = NO;
    platform3Used = NO;
    platform4Used = NO;
    platform5Used = NO;
    
    highScoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"highScoreNumber"];
    upMovement = 0;
    sideMovement = 0;
    
    [super viewDidLoad];
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
