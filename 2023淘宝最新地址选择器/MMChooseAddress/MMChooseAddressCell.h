//
//  MMChooseAddressCell.h
//  Bmncc-ylct-ios
//
//  Created by 李明 on 2023/8/8.
//

#import <UIKit/UIKit.h>
#import "MMAddressDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMChooseAddressCell : UITableViewCell


@property (nonatomic ,strong) UILabel *firstLetterLab;

@property (nonatomic ,strong) UILabel *nameLab;

@property (nonatomic ,strong) MMAddressDataModel *model;




- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
