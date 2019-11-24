//
//  MRFDetailViewController.m
//  PokeDexOBJC
//
//  Created by Michael Flowers on 11/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

#import "MRFDetailViewController.h"
#import "PokeDexOBJC-Swift.h"

void *KVOContext = &KVOContext;

@interface MRFDetailViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *pokemonImageView;
@property (nonatomic, weak) IBOutlet UILabel *identifierLabel;
@property (nonatomic, weak) IBOutlet UILabel *abilitiesLabel;

@end

@implementation MRFDetailViewController

- (void)dealloc {
    [self.pokemon removeObserver:self forKeyPath:@"abilities"];
    [self.pokemon removeObserver:self forKeyPath:@"sprite"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.pokemon) {
        NSLog(@"found Pokemon");
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
        [self.pokemon addObserver:self forKeyPath:@"sprite" options:NSKeyValueObservingOptionInitial context:KVOContext];
    } else {
        NSLog(@"No pokemon found");
    }
}

- (void)updateViews
{
    if(self.pokemon){
        [self.network fetchSpriteWith:self.pokemon completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
            if (error)
            {
                NSLog(@"Error making sprite call");
            }
            if (image)
            {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.pokemonImageView.image = image;
            });
            }
        }];
        self.identifierLabel.text = [[NSString alloc] initWithFormat:@"ID: %d", self.pokemon.identifier];
        
        NSString *abilitiesStr = [self.pokemon.abilities componentsJoinedByString:@", "];
        self.abilitiesLabel.text =  abilitiesStr;
    }else {
        NSLog(@"didn't update views with pokemon");
    }
}

@end
