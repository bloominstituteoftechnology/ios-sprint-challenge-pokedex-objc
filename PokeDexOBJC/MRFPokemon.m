//
//  MRFPokemon.m
//  PokeDexOBJC
//
//  Created by Michael Flowers on 11/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFPokemon.h"

@implementation MRFPokemon

- (nonnull instancetype)initWithName:(NSString *_Nonnull)name
                          identifier:(int)identifier
                              sprite:(NSString *_Nonnull)sprite
                           abilities:(NSArray *_Nonnull)abilities {
    return nil;
    
}

- (nullable instancetype)initWithDictionary:(NSDictionary *_Nullable)dictionary { //we need this to populate the detailView
    //initialize dictionary
    self = [super init];
    
    if (self){
        //this is where we map our properties to the names/spelling on the api
        _name = dictionary[@"name"];
        _identifier = [dictionary[@"id"] intValue];
        _sprite = dictionary[@"sprites"][@"front_default"];
        _abilities = dictionary[@"abilities"][@"ability"][@"name"];
        
    }
    return self;
}

@end
