//
//  LSIPokemonResults.m
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

#import "LSIPokemonResults.h"

@implementation LSIPokemonResults

- (instancetype)initWithResults:(NSArray<LSIPokemon *> *)results count:(NSNumber *)count next:(NSString *)next
{
    if (self = [super init]) {
        _results = results;
        _count = count;
        _next = next;
    }
    return self;
}

- (instancetype)initFromData:(NSData *)data
{
    NSError *jsonError;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

    if (!dictionary) {
        NSLog(@"Error decoding JSON: %@", jsonError);
    }

    NSNumber *count = dictionary[@"count"];
    if (![count isKindOfClass:NSNumber.class]) return nil;

    NSString *next = dictionary[@"next"];
    if (![next isKindOfClass:NSString.class]) return nil;

    NSArray *results = dictionary[@"results"];
    if (![results isKindOfClass:NSArray.class]) return nil;

    return [self initWithResults:results count:count next:next];
}

@end
