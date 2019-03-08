//
//  BHPokemonTemporaryResults.m
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import "BHPokemonTemporaryResults.h"

@implementation BHPokemonTemporaryResults

-(instancetype)initWithJSON:(id)json{
    if ([json isKindOfClass:[NSDictionary class]] == NO) { return nil;}
    
    self = [super init];
    if (self){
        
        NSString *name = [json valueForKey:@"name"];
        NSString *moreInfoURL = [json valueForKey:@"url"];
        
        _name = name;
        _moreInfoURL = moreInfoURL;
    }
    return self;
}

@end
