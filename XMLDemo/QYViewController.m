//
//  QYViewController.m
//  XMLDemo
//
//  Created by qingyun on 15-3-14.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYBook.h"
#import "GDataXMLNode.h"

@interface QYViewController () <NSXMLParserDelegate>
@property (nonatomic, strong) NSMutableArray *bookstore;
@property (nonatomic, strong) QYBook *currentBook;
@property (nonatomic, strong) NSString *content;
@end

//#define SAX

@implementation QYViewController

#ifdef SAX
- (void)viewDidLoad
{
    [super viewDidLoad];

    // 1. 获取XML文件的URL
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"bookstore" withExtension:@"xml"];
    
    // 2. 创建xml解析器对象
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    
    // 3. 设置代理
    xmlParser.delegate = self;
    
    // 4. 开始解析
    BOOL result = [xmlParser parse];
    if (!result) {
        NSLog(@"xmlParser parse error!");
        return;
    }
}

#pragma mark - xml parse delegate
// 开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    _bookstore = [NSMutableArray array];
}

// 遇到元素标签开始时
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:kBook]) {
        _currentBook = [[QYBook alloc] init];
        _currentBook.category = attributeDict[kCategory];
    }
    
    if ([elementName isEqualToString:kTitle]) {
        _currentBook.lang = attributeDict[kLang];
    }
}

// 遇到标签中的文字时
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    _content = string;
}

// 遇到元素标签结束时
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:kBook]) {
        [_bookstore addObject:_currentBook];
    } else if ([elementName isEqualToString:kBookStore]) {
        NSLog(@"Parsing will finish...");
    } else {
        [_currentBook setValue:_content forKey:elementName];
    }
}

// 结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@", _bookstore);
}

// 解析出错时
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@", parseError);
}

#else

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 创建数组对象
    _bookstore = [NSMutableArray array];
    
    // 2. 获取XML文件的URL
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"bookstore" withExtension:@"xml"];
    
    // 3. 根据URL路径，将文件读取到内存中
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    
    // 4. 创建DOM文件模型对象
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    
    // 5. 取出xml DOM🌲中根元素
    GDataXMLElement *rootElement = [doc rootElement];
    
    
    NSArray *books = [rootElement elementsForName:kBook];
    
    NSLog(@"%@", books);
    
    for (GDataXMLElement *element in books) {
        // 创建图书对象
        QYBook *book = [[QYBook alloc] init];
        
        // 根据属性名字，解析出book中的属性值
        book.category = [[element attributeForName:kCategory] stringValue];
        
        // 解析title元素
        GDataXMLElement * titleElement = [element elementsForName:kTitle][0];
        book.lang = [[titleElement attributeForName:kLang] stringValue];
        book.title = [titleElement stringValue];
        
        // 解析author元素
        GDataXMLElement *authorElement = [element elementsForName:kAuthor][0];
        book.author = [authorElement stringValue];
        
        // 解析price元素
        GDataXMLElement *priceElement = [element elementsForName:kPrice][0];
        book.price = [priceElement stringValue];
        [_bookstore addObject:book];
    }
    
    NSLog(@"bookstore: %@", _bookstore);
    
}


#endif

@end
