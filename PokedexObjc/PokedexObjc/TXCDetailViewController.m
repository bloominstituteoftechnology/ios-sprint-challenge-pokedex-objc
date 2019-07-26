//
//  TXCDetailViewController.m
//  PokedexObjc
//
//  Created by Thomas Cacciatore on 7/26/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import "TXCDetailViewController.h"
#import "TXCPokemon.h"
#import "PokedexObjc-Swift.h"


void *KVOContext = &KVOContext;

@interface TXCDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

//@property (nonatomic) TXCPokemon *pokemon;
@property PokemonAPI *pokemonAPI;

@end

@implementation TXCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setPokemon:self.pokemon];
    [[PokemonAPI sharedController] fillInDetailsFor:self.pokemon];
}

- (void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.isViewLoaded || !self.pokemon) { return; }
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = [NSString stringWithFormat:@"%d", self.pokemon.identifier];
        NSURL *imageURL = [NSURL URLWithString:self.pokemon.sprite];
        UIImage *spriteImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        self.imageView.image = spriteImage;
//        self.abilitiesLabel.text = self.pokemon.abilities[0]; //show 1 ability for now. fix later.
    });
}

- (void)setPokemon:(TXCPokemon *)pokemon {
    if (pokemon != _pokemon) {
        [_pokemon removeObserver:self forKeyPath:@"name" context:KVOContext];
        [_pokemon removeObserver:self forKeyPath:@"id" context:KVOContext];
        
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == KVOContext) {
//        [[PokemonAPI sharedController] fillInDetailsFor:self.pokemon];
        
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) dealloc {
    self.pokemon = nil;
}

@end
