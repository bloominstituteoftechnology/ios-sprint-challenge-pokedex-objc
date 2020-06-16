//
//  DSCDetailPokemonViewController.m
//  PokedexOBJC
//
//  Created by denis cedeno on 6/13/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

#import "DSCDetailPokemonViewController.h"
#import "DSCPokemon.h"
void* KVOContext = &KVOContext;

@interface DSCDetailPokemonViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilityTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation DSCDetailPokemonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.pokemon addObserver:self forKeyPath:@"pokemonSprite" options:0 context:KVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"KeyPath: %@", keyPath);
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"pokemonSprite"]) {
        [self updateViews];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    NSLog(@"dealloc");
    [self.pokemon removeObserver:self forKeyPath:@"pokemonSprite" context:KVOContext];
}

- (void)updateViews
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = self.pokemon.name.capitalizedString;
        self.imageView.image = self.pokemon.pokemonSprite;
        self.nameLabel.text = self.pokemon.name;
        if (self.pokemon.abilities) {
            self.abilityTextView.text = self.pokemon.abilities;
        } else {
            self.abilityTextView.text = @"";
        }
        self.idLabel.text = self.pokemon.pokemonID;
    });
}

@end
