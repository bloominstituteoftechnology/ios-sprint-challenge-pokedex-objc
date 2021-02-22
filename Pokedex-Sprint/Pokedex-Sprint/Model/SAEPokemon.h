//
//  SAEPokemon.h
//  Pokedex-Sprint
//
//  Created by Sammy Alvarado on 12/14/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Pokemon) // This allows me to import this Objc file into the swift file
@interface SAEPokemon : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, nonnull)NSNumber *identifier;
@property (nonatomic, nullable)UIImage *sprite;
@property (nonatomic, nonnull, copy)NSArray *abilities;

- (instancetype)initWithName:(NSString *)aName;

-(nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
