//
//  MMAddressSelectedView.m
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/8.
//

#import "MMAddressSelectedView.h"
#import "MMHeader.h"

@interface MMAddressSelectedView ()




@end
@implementation MMAddressSelectedView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.nameLab];
        
        [self addSubview:self.topLine];
        [self addSubview:self.bottomLine];
        [self addSubview:self.centerPoint];

        [self addSubview:self.rightImgV];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpAction)] ;
        [self.nameLab addGestureRecognizer:tap];
        
    }
    return self;
}


-(void)setModel:(MMAddressDataModel *)model{
    
    _model = model;
    self.nameLab.text = model.name;
    

    //如果是个空name model 圆点为空心
    if(MM_SafeStr(model.name).length == 0){
        
        if([model.level isEqualToString:@"2"]){
            self.nameLab.text = @"请选择城市";
        }else if ([model.level isEqualToString:@"3"]){
            self.nameLab.text = @"请选择县";
        }else{
            self.nameLab.text = @"请选择街道";
        }
        self.centerPoint.backgroundColor = RGB(248, 248, 248);
        [self.centerPoint mm_setPartCornerRadious:3 borderColor:[UIColor orangeColor] borderWidth:0.5 forRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight ];
    }else{
        
        self.centerPoint.backgroundColor = [UIColor orangeColor];
        [self.centerPoint mm_setNormalCornerRadious:3];
    }
    
    
    
    if(model.selected == YES){
        self.nameLab.textColor = [UIColor orangeColor];
    }else{
        self.nameLab.textColor = RGB(51, 51, 51);
    }
    
    
}



-(UILabel *)nameLab{
    if(!_nameLab){
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(45, 0, self.frame.size.width - 45, self.frame.size.height)];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = kPFFont(14);
        _nameLab.textColor = RGB(51, 51, 51);
        _nameLab.userInteractionEnabled = YES;

    }
    return _nameLab;
}

-(UIView *)topLine{
    if(!_topLine){
        _topLine = [[UIView alloc]initWithFrame:CGRectMake(22.5, 0, 0.5, self.frame.size.height/2)];
        _topLine.backgroundColor = [UIColor orangeColor];
    }
    return _topLine;
}


-(UIView *)centerPoint{
    if(!_centerPoint){
        _centerPoint = [[UIView alloc]initWithFrame:CGRectMake(19.5,self.frame.size.height/2 - 6/2 , 6, 6)];
    }
    return _centerPoint;
}


-(UIView *)bottomLine{
    if(!_bottomLine){
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(22.5, self.frame.size.height/2, 0.5, self.frame.size.height/2)];
        _bottomLine.backgroundColor = [UIColor orangeColor];
    }
    return _bottomLine;
}


-(UIImageView *)rightImgV{
    if(!_rightImgV){
        _rightImgV = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 6 - 22, self.frame.size.height/2 - 10/2, 6, 10)];
        _rightImgV.image = [UIImage imageNamed:@"通用_灰色右向箭头"];
    }
    return _rightImgV;
}

- (void)jumpAction
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(mmAddressSelectedViewDidTouch:)]){
        [self.delegate mmAddressSelectedViewDidTouch:_model];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
