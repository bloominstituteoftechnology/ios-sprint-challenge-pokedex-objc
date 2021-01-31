//
//  Pokemon.m
//  PokedexSprint
//
//  Created by Norlan Tibanear on 1/31/21.
//

#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithName:(NSString *)aName {
    
    if (self = [super init]) {
        _name = aName.copy;
    }
    return self;
}//

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *name = [dictionary objectForKey:@"name"];
    if (![name isKindOfClass:NSString.class]) return nil;
    return [self initWithName:name];
}//




@end
