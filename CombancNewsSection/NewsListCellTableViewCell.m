//
//  NewsListCellTableViewCell.m
//  OANoticeNews
//
//  Created by Golden on 2018/9/11.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "NewsListCellTableViewCell.h"
#import "UIColor+NewsCategory.h"
#import "Masonry.h"

@implementation NewsListCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
    self.titleLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    [self.contentView addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.timeLabel.textColor = [UIColor colorWithHex:@"#8e8e93"];
    [self.contentView addSubview:self.timeLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.top.equalTo(self.contentView.mas_top).offset(18);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
}

@end
