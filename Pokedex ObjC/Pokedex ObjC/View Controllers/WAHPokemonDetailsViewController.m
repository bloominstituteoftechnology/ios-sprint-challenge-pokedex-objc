//
//  WAHPokemonDetailsViewController.m
//  Pokedex ObjC
//
//  Created by Wyatt Harrell on 5/22/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

#import "WAHPokemonDetailsViewController.h"

void *KVOContext = &KVOContext;

@interface WAHPokemonDetailsViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation WAHPokemonDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.pokemonController fillInDetailsFor:self.pokemon];
    [self.pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"image" options:0 context:KVOContext];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        if ([keyPath isEqualToString:@"identifier"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"abilities"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"image"]) {
            [self fetchImage];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateViews {    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = [NSString stringWithFormat:@"%i", self.pokemon.identifier];

        NSString *joinedComponents = [self.pokemon.abilities componentsJoinedByString:@", "];
        self.abilitiesLabel.text = joinedComponents;

    });
}

- (void)fetchImage {
    [self.pokemonController getImageAt:self.pokemon.image completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image];
        });
        
    }];
}


@end
