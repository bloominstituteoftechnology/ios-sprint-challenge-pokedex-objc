//
//  LSIPokemon.m
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "LSIPokemon.h"

@implementation LSIPokemon

- (instancetype)initWithName:(NSString *)name url:(NSString *)urlString
{
    if (self = [super init]) {
        _name = name;
        _urlString = urlString;
        _abilities = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initFromDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    if (![name isKindOfClass:NSString.class]) return nil;

    NSString *urlString = dictionary[@"url"];
    if (![urlString isKindOfClass:NSString.class]) return nil;

    return [self initWithName:name url:urlString];
}

@end
