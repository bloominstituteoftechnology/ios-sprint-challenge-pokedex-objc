//
//  IACPokemonDetailViewController.m
//  Sprint 12: Objective-C Pokedex
//
//  Created by Ivan Caldwell on 3/15/19.
//  Copyright © 2019 Ivan Caldwell. All rights reserved.
//

#import "IACPokemonDetailViewController.h"
#import "Sprint_12__Objective_C_Pokedex-Swift.h"

@interface IACPokemonDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pokemonIDLabel;
@property (weak, nonatomic) IBOutlet UITextView *pokemonAbilityTextView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilityLabel;
@end

@implementation IACPokemonDetailViewController
- (void) viewDidLoad {
    [super viewDidLoad];
    /*
     Your network controller must have an interface as specified below. Note that the fillInDetails
     method does not take a completion closure. Rather, it fills in additional details (identifier,
     abilities, sprite) by setting pokemon 's properties directly.
     */
    if (self.pokemon.pokemonID == nil) {
        [self.pokemon addObserver: self
                       forKeyPath: @"abilities"
                          options: 0
                          context: nil];
        
    }
    [PokemonController.sharedController fillInDetailsFor:self.pokemon];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateViews];
}

- (void) updateViews {
    if (self.pokemon) {
        self.title = [self.pokemon.pokemonName capitalizedString];
        self.pokemonNameLabel.text = [NSString stringWithFormat:@"Name: %@", [self.pokemon.pokemonName capitalizedString]];
        self.pokemonIDLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.pokemonID];
        self.pokemonAbilityLabel.text = (self.pokemon.pokemonAbilities.count > 1) ? @"Abilities:" : @"Ability:";
        self.pokemonAbilityTextView.text = [[self.pokemon.pokemonAbilities componentsJoinedByString:@"\n"] capitalizedString];
        
        NSData *data = [NSData dataWithContentsOfURL:self.pokemon.pokemonFrontDefaultURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemonImageView.image = [UIImage imageWithData:data];
        });
    }
}

// The detail view controller must use KVO to be notified when the network controller has
// finished filling in details for a Pokemon, triggering a UI update.
- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    [object removeObserver:self forKeyPath:keyPath];
}
@end
