//
//  PNCPokemon.m
//  Pokedex-ObjC
//
//  Created by Lambda_School_Loaner_263 on 1/31/20.
//  Copyright © 2020 Lambda_School_Loaner_263. All rights reserved.
//

#import "PNCPokemon.h"

@implementation PNCPokemon

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _name = dictionary[@"name"];
                           NSString *urlString = dictionary[@"url"];
        _url = [NSURL URLWithString:urlString];
    }
    return self;
}

@end
