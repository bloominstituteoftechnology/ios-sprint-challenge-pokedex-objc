//
//  JCSDetailViewController.m
//  PokedexObjC
//
//  Created by Lambda_School_Loaner_95 on 4/12/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import "JCSDetailViewController.h"
#import "JCSPokemon.h"
#import "JCSPokemonController.h"
#import <UIKit/UIKit.h>

void *KVOContext = &KVOContext;

@interface JCSDetailViewController ()

@end

@implementation JCSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemon addObserver:self forKeyPath:@"isFilled" options:0 context:KVOContext];
    [self.pokemonController fillInDetails:self.pokemon];
    
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:@"isFilled" context:KVOContext];
    NSLog(@"Dealloc method");
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"isFilled"]) {
            NSLog(@"In keyPath in detail views, pokemon has been updated!");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateViews];
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateViews {
    _nameLabel.text = [NSString stringWithFormat:@"Name: %@", self.pokemon.name];
    _idLabel.text = [NSString stringWithFormat:@"ID: %ld", (long)self.pokemon.identifier];
    
    NSMutableString *abString = [[NSMutableString alloc] init];
    for (NSString *ab in (self.pokemon.abilities)) {
        [abString appendString:[NSString stringWithFormat: @"\n%@", ab]];
    }
    _abilitiesLabel.text = abString;
    NSLog(@"Photo URL: %@", self.pokemon.photoURL);
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.pokemon.photoURL]];
    _pokemonImageView.image = [UIImage imageWithData:data];
}



@end
