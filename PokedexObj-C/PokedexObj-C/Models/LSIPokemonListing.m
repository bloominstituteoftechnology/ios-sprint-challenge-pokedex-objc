//
//  LSIPokemonListing.m
//  PokedexObj-C
//
//  Created by James McDougall on 3/5/21.
//

#import "LSIPokemonListing.h"

@implementation LSIPokemonListing

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url {
    if (self = [super init]) {
        _name = name;
        _url = url;
    }
    return self;
}

@end
