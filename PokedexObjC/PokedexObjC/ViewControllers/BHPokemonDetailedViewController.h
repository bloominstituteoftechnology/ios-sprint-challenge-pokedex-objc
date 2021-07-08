//
//  PokemonDetailedViewController.h
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/9/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHPokemon.h"
#import "PokedexObjC-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface BHPokemonDetailedViewController : UIViewController

@property BHPokemon *objectToObserve;
@property PokemonAPI *pokemonAPI;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speciesLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)segmentControlTapped:(id)sender;

-(void)updateViews;
@end

NS_ASSUME_NONNULL_END
