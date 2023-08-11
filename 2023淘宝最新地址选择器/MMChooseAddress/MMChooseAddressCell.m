//
//  MMChooseAddressCell.m
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/8.
//

#import "MMChooseAddressCell.h"
#import "MMHeader.h"


@implementation MMChooseAddressCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.contentView.backgroundColor = RGB(248, 248, 248);
        [self.contentView addSubview:self.firstLetterLab];
        [self.contentView addSubview:self.nameLab];
    }
    return self;
}


-(UILabel *)firstLetterLab{
    if(!_firstLetterLab){
        _firstLetterLab = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 10, 38)];
        _firstLetterLab.textAlignment = NSTextAlignmentLeft;
        _firstLetterLab.font = kPFFont(12);
        _firstLetterLab.textColor = RGB(153, 153, 153);
    }
    return _firstLetterLab;
}

-(UILabel *)nameLab{
    if(!_nameLab){
        _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, 300, 38)];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = kPFFont(14);
        _nameLab.textColor = RGB(51, 51, 51);
    }
    return _nameLab;
}

-(void)setModel:(MMAddressDataModel *)model{
    
    self.firstLetterLab.text = MM_SafeStr(model.firstLetter);
    self.nameLab.text = model.name;
}


- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView {
    // Determine if this is the first or last cell in the table section
    BOOL isFirstRow = indexPath.row == 0;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
