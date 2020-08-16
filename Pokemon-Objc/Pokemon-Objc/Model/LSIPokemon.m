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

- (BOOL)updateWithDetailsData:(NSData *)data
{
    NSError *jsonError;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (!dictionary) {
        NSLog(@"Error decoding JSON: %@", jsonError);
    }
    
    NSNumber *identifier = dictionary[@"id"];
    if (![identifier isKindOfClass:NSNumber.class]) return nil;
    
    NSString *spriteURLString = dictionary[@"sprites"][@"front_default"];
    if (![spriteURLString isKindOfClass:NSString.class]) return nil;
    
    // TODO: abilities
    
    self.spriteURLString = spriteURLString;
    self.identifier = identifier;
    
    return true;
}

@end
