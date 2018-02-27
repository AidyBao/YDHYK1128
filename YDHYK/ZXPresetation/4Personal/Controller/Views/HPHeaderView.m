//
//  HPHeaderView.m
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HPHeaderView.h"
#import "ZXAllUnReadCountModel.h"

@interface HPHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *vTopContent;
@property (weak, nonatomic) IBOutlet ZXImageView *imgHeader;//头像
@property (weak, nonatomic) IBOutlet UILabel *lbName;//名字
@property (weak, nonatomic) IBOutlet ZXLabel *lbScores;//积分
@property (weak, nonatomic) IBOutlet ZXLabel *lbNewMsgCount;

@end

@implementation HPHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *containerView = [[[UINib nibWithNibName:@"HPHeaderView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 160);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        [self setBackgroundColor:ZXCLEAR_COLOR];
        [containerView setBackgroundColor:ZXCLEAR_COLOR];
        
        [_lbNewMsgCount setFont:[UIFont zx_titleFontWithSize:12]];
        [_lbNewMsgCount setBackgroundColor:[UIColor zx_customBColor]];
        
//        [self.vTopContent setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"h_back_snap"]]];
        [self.vTopContent setBackgroundColor:[UIColor zx_navbarColor]];
        [_imgHeader setBackgroundColor:[UIColor zx_separatorColor]];
        
        [ZXNotificationCenter addObserver:self selector:@selector(updateUnReadCount:) name:ZXNOTICE_UPDATE_UNREAD_MSG_COUNT object:nil];
    }
    return self;
}

- (void)updateUnReadCount:(NSNotification *)notice{
    if ([notice.object isKindOfClass:[ZXAllUnReadCountModel class]]) {
        ZXAllUnReadCountModel * model = (ZXAllUnReadCountModel *)notice.object;
        if (model.promotionUnRead <= 0 ) {
            [_lbNewMsgCount setHidden:true];
        }else{
            [_lbNewMsgCount setHidden:false];
            [_lbNewMsgCount setText:[NSString stringWithFormat:@"%@",@(model.promotionUnRead)]];
        }
        [_lbScores setText:[NSString stringWithFormat:@"%@积分",@(model.integral)]];
    }
}

- (IBAction)hpButtonAction:(UIButton *)sender {
    HPMenuActionType type = HPNoneActionType;
    if (sender.tag == 11) {//消息
        type = HPMessageActionType;
    }else if(sender.tag == 22){//设置
        type = HPSettingActionType;
    }else if(sender.tag == 33){//编辑资料
        type = HPEditInfoActionType;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(headerMenuActionsWithType:)]) {
        [_delegate headerMenuActionsWithType:type];
    }
}

- (void)refreshData{
    id headerUrl = [[YDAPPManager shareManager]  getUserHeadPortraitFilesStr];
    if ([headerUrl isKindOfClass:[NSString class]] && [headerUrl length]) {
        if ([[[YDAPPManager shareManager] getUserSex] integerValue] == 0) {//女
            [_imgHeader setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"touxiang-woman"]];
        }else{
            [_imgHeader setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"touxiang-man"]];
        }
        
    }else{
        if ([[[YDAPPManager shareManager] getUserSex] integerValue] == 0) {//女
            [_imgHeader setImage:[UIImage imageNamed:@"touxiang-woman"]];
        }else{
            [_imgHeader setImage:[UIImage imageNamed:@"touxiang-man"]];
        }
    }
    [_lbName setText:[[YDAPPManager shareManager] getUserName]];
    if ([ZXStringUtils isTextEmpty:[[YDAPPManager shareManager] getUserCurrentIntegral]]) {
        [_lbScores setText:@"0积分"];
    }else{
        [_lbScores setText:[NSString stringWithFormat:@"%@积分",[[YDAPPManager shareManager] getUserCurrentIntegral]]];
    }
}

- (void)dealloc{
    [ZXNotificationCenter removeObserver:self name:ZXNOTICE_UPDATE_UNREAD_MSG_COUNT object:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
