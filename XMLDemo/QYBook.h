//
//  QYBook.h
//  XMLDemo
//
//  Created by qingyun on 15-3-14.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBookStore  @"bookstore"
#define kBook       @"book"
#define kTitle      @"title"
#define kAuthor     @"author"
#define kYear       @"year"
#define kPrice      @"price"
#define kCategory   @"category"
#define kLang       @"lang"

@interface QYBook : NSObject
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *lang;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *price;

@end
