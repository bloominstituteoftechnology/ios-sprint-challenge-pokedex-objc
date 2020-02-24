//
//  PokemonDetailViewController.m
//  Pokedex-Objc
//
//  Created by Joel Groomer on 2/22/20.
//  Copyright © 2020 Julltron. All rights reserved.
//

#import "PokemonDetailViewController.h"
#import "Pokemon.h"

@interface PokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblPokemonID;
@property (weak, nonatomic) IBOutlet UIImageView *imgPokemonSprite;
@property (weak, nonatomic) IBOutlet UILabel *lblPokemonName;
@property (weak, nonatomic) IBOutlet UITextView *txtvAbilities;

@end

void *KVODetailViewContext = &KVODetailViewContext;

@implementation PokemonDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateViews];
    if (self.pokemon) {
        [self.pokemon addObserver:self forKeyPath:@"sprite" options:0 context:KVODetailViewContext];
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVODetailViewContext];
        [self.pokemon updateDetails];
    }
}

- (void)updateViews
{
    if (self.view && self.pokemon) {
        self.lblPokemonID.text = [NSString stringWithFormat:@" # %d ", self.pokemon.pokemonID];
        self.lblPokemonName.text = self.pokemon.name;
        if (self.pokemon.sprite) {
            self.imgPokemonSprite.image = self.pokemon.sprite;
        }
        NSString *newAbilities = @"";
        if (self.pokemon.abilities.count > 0) {
            for (NSString *ability in self.pokemon.abilities) {
                NSLog(@"Ability: %@", ability);
                newAbilities = [newAbilities stringByAppendingFormat:@"%@\n", ability];
                NSLog(@"Abilities: %@", newAbilities);
            }
            self.txtvAbilities.text = newAbilities;
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVODetailViewContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
