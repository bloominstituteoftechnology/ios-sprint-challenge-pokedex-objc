//
//  FCCDetailPokemonViewController.m
//  Pokedex
//
//  Created by Lambda_School_Loaner_34 on 4/12/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

#import "FCCDetailPokemonViewController.h"
#import "FCCPokemon.h"
#import "Pokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface FCCDetailPokemonViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *pokemonSprite;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation FCCDetailPokemonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void) updateViews {
    if (self.pokemon) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
        self.title = [self.pokemon.name capitalizedString];
        self.nameLabel.text = [self.pokemon.name capitalizedString];
        self.identifierLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
        
        NSString *abilitiesString = [[self.pokemon.abilities componentsJoinedByString:@", "] capitalizedString];
        self.abilitiesLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilitiesString];
        
        [self placeImage];
        });
    }
}

-(void) placeImage {
    NSURL *imageURL = self.pokemon.sprite;
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error getting image %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"No data returned from data task");
            return;
        }
        
        UIImage *sprite = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self pokemonSprite] setImage:sprite];
        });
        
    }];
    [dataTask resume];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (context == KVOContext) {
            [self updateViews];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
    
- (void) dealloc; {
    [self.pokemon removeObserver:self forKeyPath:@"sprite" context:&KVOContext];
}

- (void)setPokemon:(FCCPokemon *)pokemon {
    
    if (pokemon != _pokemon) {
        _pokemon = pokemon;
        [self.pokemon addObserver:self forKeyPath:@"sprite" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}

@end
