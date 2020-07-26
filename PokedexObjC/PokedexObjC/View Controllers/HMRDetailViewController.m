//
//  HMRDetailViewController.m
//  PokedexObjC
//
//  Created by Harmony Radley on 7/24/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

#import "HMRDetailViewController.h"

void *KVOContext = &KVOContext;

@interface HMRDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *abilitiesLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;

@end

@implementation HMRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.pokemonController fillInDetailsFor:self.pokemon];
    [self.pokemon addObserver:self forKeyPath:@"identifier" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"image" options:0 context:KVOContext];
    [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:KVOContext];
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

        NSString *componentsJoined = [self.pokemon.abilities componentsJoinedByString:@", "];
        self.abilitiesLabel.text = componentsJoined;

    });
}

- (void)fetchImage {
    [self.pokemonController fetchImageWith:self.pokemon.image completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:image];
        });

    }];
}

- (void)dealloc {
    [self.pokemon removeObserver:self forKeyPath:@"identifier" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"abilities" context:KVOContext];
    [self.pokemon removeObserver:self forKeyPath:@"image" context:KVOContext];
}

@end
