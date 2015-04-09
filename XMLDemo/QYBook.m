//
//  QYBook.m
//  XMLDemo
//
//  Created by qingyun on 15-3-14.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYBook.h"

@implementation QYBook

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"Book:<category:%@ language:%@ title:%@ author:%@ year:%@ price:%@>", _category, _lang, _title, _author, _year, _price];
    
    return desc;
}

@end
