//
//  RPViewController.m
//  Pressure
//
//  Created by 郑 eason on 13-10-27.
//  Copyright (c) 2013年 EasonCompany. All rights reserved.
//

#import "RPIndexVCTL.h"
#import "RPFrChatIndexVCTL.h"
#import "RPAutoGenSettingVCTL.h"
#import "AutoGen.h"
#import "RPAuthModel.h"
#import "RPProfile.h"
#import "RPXmppManager.h"
#import "RPForumVCTL.h"
#import "RPFrChatVCTL.h"

#import "MLNavigationController.h"
#import "RPAppDelegate.h"
@interface RPIndexVCTL ()

@end

@implementation RPIndexVCTL

- (void)viewDidLoad
{
    self.hideHeaderBar = YES;
    [super viewDidLoad];
    
    UIButton *holeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [holeBtn addTarget:self action:@selector(holeClick:) forControlEvents:UIControlEventTouchUpInside];
    holeBtn.frame = CGRectMake(0, 0, 100, 44);
    
    [holeBtn setTitle:@"树洞" forState:UIControlStateNormal];
    [self.contentView addSubview:holeBtn];
    
    
    UIButton *frBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [frBtn addTarget:self action:@selector(frClick:) forControlEvents:UIControlEventTouchUpInside];
    frBtn.frame = CGRectMake(50, 50, 100, 44);
    
    [frBtn setTitle:@"神父" forState:UIControlStateNormal];
    [self.contentView addSubview:frBtn];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [settingBtn addTarget:self action:@selector(settingClick:) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.frame = CGRectMake(100, 100, 100, 44);
    
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [self.contentView addSubview:settingBtn];
    
    
    UIButton *forumBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [forumBtn addTarget:self action:@selector(forumClick:) forControlEvents:UIControlEventTouchUpInside];
    forumBtn.frame = CGRectMake(150, 150, 100, 44);
    
    [forumBtn setTitle:@"论坛" forState:UIControlStateNormal];
    [self.contentView addSubview:forumBtn];
    
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    if (!authModel.connectedOpenFireSucc)
    {
        [[RPXmppManager sharedInstance] doConnect:[authModel.profile.xmppProfile jID] xmppPassWord:[authModel.profile.xmppProfile password]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleXmppLoginSuccNotif:) name:kNotif_XmppLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleXmppLoginFailedNotif:) name:kNotif_XmppLoginFailed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTalkerFindFatherNotif:) name:kNotif_TalkerFindFather object:nil];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)holeClick:(id)sender
{
    
}

- (void)forumClick:(id)sender
{
    RPForumVCTL *forumVCTL = [[RPForumVCTL alloc] init];
    [self.navigationController pushViewController:forumVCTL animated:YES];
}

- (void)frClick:(id)sender
{
    RPFrChatIndexVCTL *chatVCTL = [[RPFrChatIndexVCTL alloc] init];
    [self.navigationController pushViewController:chatVCTL animated:YES];
}

- (void)settingClick:(id)sender
{
    NSString *path      = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    NSDictionary *dic   = [[NSDictionary alloc] initWithContentsOfFile:path];
    AutoGen *autoGen    = [[AutoGen alloc] initWithJSONDic:dic];
    RPAutoGenSettingVCTL *settingVCTL = [[RPAutoGenSettingVCTL alloc] init];
    settingVCTL.autoGen = autoGen;
    [self.navigationController pushViewController:settingVCTL animated:YES];
}

#pragma mark -
#pragma mark Xmpp Notification
- (void)handleXmppLoginSuccNotif:(NSNotification *)notif
{
    MLOG(@"登陆成功");
    [[RPXmppManager sharedInstance] sendOnlineStatus:User_Xmpp_OnlineStatus_Online];
    RPAuthModel *authModel = [RPAuthModel sharedInstance];
    authModel.connectedOpenFireSucc = YES;
}

- (void)handleXmppLoginFailedNotif:(NSNotification *)notif
{
    MLOG(@"登陆失败");
}

- (void)handleTalkerFindFatherNotif:(NSNotification *)notif
{
    RPAppDelegate *delegate = (RPAppDelegate *)[UIApplication sharedApplication].delegate;
    if ([[delegate.nav topViewController] isKindOfClass:[RPFrChatVCTL class]])
    {
        return;
    }
    RPFrChatVCTL *chatVCTL = [[RPFrChatVCTL alloc] init];
    [self.navigationController pushViewController:chatVCTL animated:YES];
}



@end
