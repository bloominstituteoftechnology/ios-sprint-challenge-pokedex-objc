//
//  JCSDetailViewController.h
//  PokedexObjC
//
//  Created by Lambda_School_Loaner_95 on 4/12/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JCSPokemon;
NS_SWIFT_NAME(DetailViewController)
NS_ASSUME_NONNULL_BEGIN

@interface JCSDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@property JCSPokemon *pokemon;


@end

NS_ASSUME_NONNULL_END
