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
    [self updateViews];
    if (!self.pokemon.idNumber) {
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:nil];
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self updateViews];
    });
    [object removeObserver:self forKeyPath:keyPath];
}

-(void) updateViews {
    if (self.pokemon) {
        self.title = [self.pokemon.name capitalizedString];
        [self loadSprite];
        self.idLabel.text = [NSString stringWithFormat:@"#%@", self.pokemon.idNumber];
        NSString *abilitiesString = [[self.pokemon.abilities componentsJoinedByString:@", "] capitalizedString];
        self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilitiesString];
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
