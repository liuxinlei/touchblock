//
//  AdsAdmob.m
//  touchblock
//
//  Created by tracy on 14-4-20.
//
//

#import "AdsAdmob.h"

@implementation AdsAdmob

//static GADBannerView *bannerView_ = nil;

-(void)addAdMob
{
    // 在屏幕低部创建标准尺寸的视图。
    // 在GADAdSize.h中对可用的AdSize常量进行说明。
    bannerView_ = [[GADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - GAD_SIZE_320x50.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    
    // 指定广告单元ID。
    bannerView_.adUnitID = @"a1534bc2f0899e9";
    
    // 告知运行时文件，在将用户转至广告的展示位置之后恢复哪个UIViewController
    // 并将其添加至视图层级结构。
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    // 启动一般性请求并在其中加载广告。
    [bannerView_ loadRequest:[GADRequest request]];
}


-(void)releaseAdMob {
    [bannerView_ release];
    [super dealloc];
}

@end
