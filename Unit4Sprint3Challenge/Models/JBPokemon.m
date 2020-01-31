//
//  JBPokemon.m
//  Unit4Sprint3Challenge
//
//  Created by Jon Bash on 2020-01-31.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

#import "JBPokemon.h"

@implementation JBPokemon

- (instancetype _Nonnull)initWithName:(NSString *_Nonnull)name
                            detailURL:(NSURL *_Nonnull)detailURL
{
    self = [super init];
    if (self) {
        _name = name;
        _detailURL = detailURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *detailURLString = dictionary[@"url"];
    NSURL *detailURL = [NSURL URLWithString:detailURLString];

    if (name == nil || detailURL == nil) { return nil; }

    return [self initWithName:name detailURL:detailURL];
}

@end
