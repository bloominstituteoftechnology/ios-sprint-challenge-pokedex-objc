//
//  MBPokemonDetailViewController.m
//  PokedexObjC
//
//  Created by Mitchell Budge on 7/26/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import "MBPokemonDetailViewController.h"
#import "PokedexObjC-Swift.h"

void *KVOContext = &KVOContext;

@interface MBPokemonDetailViewController ()

@end

@implementation MBPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)fetchPokemon:(MBPokemon *)pokemon {
    if (pokemon != _pokemon)
    {
        _pokemon = pokemon;
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

- (void)dealloc {
    [self.pokemon removeObserver:self forKeyPath:@"abilities" context:&KVOContext];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void) updateViews {
    if (self.pokemon) {
        self.title = [self.pokemon.name capitalizedString];
        self.idLabel.text = [NSString stringWithFormat:@"#%@", self.pokemon.idNumber];
        NSString *abilitiesString = [[self.pokemon.abilities componentsJoinedByString:@", "] capitalizedString];
        self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilitiesString];
        [self loadSprite];
    }
}

-(void) loadSprite {
    NSURL *spriteURL = self.pokemon.sprite;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:spriteURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error)
        {
            NSLog(@"Error getting sprite data %@", error);
            return;
        }
        UIImage *sprite = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self imageView] setImage:sprite];
        });
    }];
    [dataTask resume];
}

@end
