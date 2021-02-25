//
//  Pokemon.h
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/23/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, nullable) NSNumber *identifier;
@property (nonatomic, nullable, copy) NSString *abilities;
@property (nonatomic, copy) NSString *sprites;

- (instancetype)initWithIdentifier:(NSNumber *)anIdentifier
                              name:(NSString *)aName
                         abilities:(NSString *)anAbility
                           sprites:(NSString *)aSpriteURL;

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary;

- (void)updateWithID:(NSNumber *)anID
                name:(NSString *)aName
           abilities:(NSString *)anAbility
             sprites:(NSString *)aSpriteURL;

@end

NS_ASSUME_NONNULL_END
