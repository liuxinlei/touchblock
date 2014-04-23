//
//  GameCenter.m
//  flappy_climber
//
//  Created by tracy on 14-4-14.
//
//

#import "GameCenter.h"

static UIViewController* currentModalViewController = nil;

@implementation GameCenter

+(void) login{
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error){
        if (error == nil) {
            //成功处理
            NSLog(@"成功");
        }else {
            //错误处理
            NSLog(@"失败  %@",error);
        }
    }];
}

+(void)showLeaderboard{
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil) {
        leaderboardController.leaderboardDelegate = self;
        leaderboardController.viewState = GKGameCenterViewControllerStateDefault;
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        currentModalViewController = [[UIViewController alloc] init];
        [window addSubview:currentModalViewController.view];
        [currentModalViewController presentModalViewController:leaderboardController animated:YES];
    }
}

+(void)reportScore:(NSDictionary *)dict{
    int64_t *score = [[dict objectForKey:@"score"] intValue];
    NSString *category = [dict objectForKey:@"category"];
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
    scoreReporter.value = score;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil)
        {
            NSLog(@"上传分数出错.");
        }
        else
        {
            NSLog(@"上传分数成功");
        }
    }];
}

+ (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    if(currentModalViewController !=nil){
        [currentModalViewController dismissModalViewControllerAnimated:NO];
        [currentModalViewController release];
        [currentModalViewController.view removeFromSuperview];
        currentModalViewController = nil;
    }
}

@end
