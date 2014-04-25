//
//  ClientCell.m
//  PersonalTraining
//
//  Created by Amelie on 14-3-12.
//  Copyright (c) 2014年 COMP41550. All rights reserved.


#import "SampleCell.h"

#define CLIENT_IMG_WIDTH 41
#define CLIENT_IMG_HEIGHT 41

@implementation SampleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

-(void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
}
@end
