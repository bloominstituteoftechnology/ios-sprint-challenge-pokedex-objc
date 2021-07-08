//
//  HSVPokemonViewController.h
//  Pokedex
//
//  Created by Hector Steven on 7/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HSVPokemon;
NS_ASSUME_NONNULL_BEGIN

@interface HSVPokemonViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;


@property (nonatomic) HSVPokemon *pokemon;
@end

NS_ASSUME_NONNULL_END
