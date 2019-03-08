//
//  OSIPokemon.h
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSIAbility.h"



NS_ASSUME_NONNULL_BEGIN


@interface OSIPokemon : NSObject
@property (nonatomic, nullable) NSString *name;
@property (nonatomic, nullable) NSArray<OSIAbility *> *abilities;
@property (nonatomic, nullable) NSString *imageURL;
@property (nonatomic, copy, nullable) NSURL *url;
@property (readwrite, nullable) NSNumber *identifier;

- (instancetype)initWithJSON:(id)json;






- (instancetype)initWithName:(NSString *)name url:(NSURL *)url;

-(nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end


NS_ASSUME_NONNULL_END

//class PokemonAPI: NSObject {
//
//    @objc(sharedController) static let shared: PokemonAPI
//
//    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void)
//
//    @objc func fillInDetails(for pokemon: LSIPokemon)
//}
