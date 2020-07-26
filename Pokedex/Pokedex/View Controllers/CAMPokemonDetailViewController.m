//
//  CAMPokemonDetailViewController.m
//  Pokedex
//
//  Created by Cody Morley on 7/24/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

#import "CAMPokemonDetailViewController.h"
#import "Pokedex-Swift.h"
#import "CAMPokemon.h"

@interface CAMPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *spriteView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;


@end

@implementation CAMPokemonDetailViewController
//MARK: - Life Cycles -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver:self
           forKeyPath:@"pokemon"
              options:0
              context:nil];
    _pokedex = PokedexAPIController.shared;
    self.pokemon = [self.pokedex fillInDetailsFor: self.pokemonID];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.spriteView.image = [self.pokedex getSpriteFor: self.pokemon];
    });
}


//MARK: - Methods -
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"pokemon"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    }
}

-(void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *idString = [NSString stringWithFormat: @"%d", self.pokemon.number];
        NSString *abilitiesString = @"";
        if (!self.pokemon.abilities) {
            for (NSString *ability in self.pokemon.abilities) {
                [abilitiesString stringByAppendingString:ability];
            }
        }
        
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = idString;
        self.abilitiesLabel.text = abilitiesString;
    });
}

@end
