//
//  Pokemon.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/23/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

-(instancetype)initDictionary:(nullable NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"url"];
    
    return [self initWithName:name url:url id:NULL abilities:NULL sprite:NULL];
}

-(instancetype)initWithName:(NSString *)name url:(NSString *)url id:(nullable NSString *)id abilities:(nullable NSMutableArray<NSString *> *)abilities sprite:(nullable NSString *)sprite
{
    if (self = [super init]) {
        _name = name;
        _url = url;
        _id = id;
        _abilities = abilities;
        _sprite = sprite;
    }
    return self;
}



@end

//Make sure objects are in right format

