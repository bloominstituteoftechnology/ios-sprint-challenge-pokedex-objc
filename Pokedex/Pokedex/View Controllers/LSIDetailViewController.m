//
//  LSIDetailViewController.m
//  Pokedex
//
//  Created by Alex on 7/26/19.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "LSIDetailViewController.h"
#import "Pokedex-Swift.h" // birdge

@interface LSIDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *identifierLbl;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLbl;
@property (weak, nonatomic) IBOutlet UIImageView *spriteImageView;

@end

void *KVOContext = &KVOContext;

@implementation LSIDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LSIPokemonAPI.sharedController fillInDetailsFor: _pokemon];
}

- (void)updateViews {
    NSString *name = [NSString stringWithFormat: @"Name: %@", self.pokemon.name];
    NSString *identifier = [NSString stringWithFormat: @"ID: %@", self.pokemon.identifier];
    
    [self.spriteImageView setImage:self.pokemon.image];
    [self.nameLbl setText: name];
    [self.identifierLbl setText: identifier];
    [self.abilitiesLbl setText:[self.pokemon.abilities componentsJoinedByString:@", "]];
    
    NSLog(@"HERE: ", self.pokemon.abilities, name, identifier);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setPokemon:(LSIPokemon *)pokemon {
    if(pokemon != _pokemon) {
        _pokemon = pokemon;
        
        [_pokemon addObserver:self forKeyPath:@"iage" options:NSKeyValueObservingOptionInitial context: KVOContext];
        [_pokemon addObserver:self forKeyPath:@"id" options:NSKeyValueObservingOptionInitial context: KVOContext];
        [_pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context: KVOContext];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
