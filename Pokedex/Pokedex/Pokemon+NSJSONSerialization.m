//
//  Pokemon+NSJSONSerialization.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/23/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "Pokemon+NSJSONSerialization.h"
#import <UIKit/UIKit.h>
#import "Pokemon.h"


@implementation Pokemon (NSJSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSString *url = dictionary[@"url"];
    
    return [self initWithName:name url:url];
}

- (NSDictionary *)toDictionary
{
    NSDictionary *dictionary;
    return dictionary;
}

@end
