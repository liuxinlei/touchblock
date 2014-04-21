//
//  GameCenter.h
//  flappy_climber
//
//  Created by tracy on 14-4-14.
//
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GameCenter : GKLeaderboardViewController<GKLeaderboardViewControllerDelegate>

+(void) login;

+(void) showLeaderboard;

+(void) reportScore:(NSDictionary *)dict;

@end
