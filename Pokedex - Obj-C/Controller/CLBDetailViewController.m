//
//  CLBDetailViewController.m
//  Pokedex - Obj-C
//
//  Created by Christian Lorenzo on 6/13/20.
//  Copyright © 2020 Christian Lorenzo. All rights reserved.
//

#import "CLBDetailViewController.h"
#import "Pokedex___Obj_C-Swift.h"

@interface CLBDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

- (UIColor * _Nullable )getColor;

@end

@implementation CLBDetailViewController

- (void)configureView {
    if (self.pokemon) {
        
        self.title = [self.pokemon.name capitalizedString];
        
        if (self.pokemon.identifier) {
            self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
        }
        
        if (self.pokemon.abilities) {
            NSString *abilityString = [self.pokemon.abilities componentsJoinedByString:@", "];
            self.abilityLabel.text = [NSString stringWithFormat:@"Abilities: %@", abilityString];
        }
        
        if (self.pokemon.sprite) {
            NSURL *url = [NSURL URLWithString:self.pokemon.sprite];
            [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = [UIImage imageWithData:data];
                    });
                }
            }] resume];
        }
        if (self.pokemon.type) {
            self.typeLabel.text = [NSString stringWithFormat:@"Type: %@", [self.pokemon.type capitalizedString]];
            [self.view setBackgroundColor:[self getColor]];
        }
    }
    
}

- (UIColor * _Nullable )getColor {
    // Elements
    if ([self.pokemon.type isEqualToString:@"dark"] ) {
        return [UIColor colorWithRed:5/255.0 green:7/255.0 blue:7/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"electric"] ) {
        return [UIColor colorWithRed:226/255.0 green:210/255.0 blue:43/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"fighting"] ) {
        return [UIColor colorWithRed:239/255.0 green:98/255.0 blue:57/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"fire"] ) {
        return [UIColor colorWithRed:253/255.0 green:119/255.0 blue:48/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"flying"] ) {
        return [UIColor colorWithRed:148/255.0 green:179/255.0 blue:199/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"grass"] ) {
        return [UIColor colorWithRed:38/255.0 green:203/255.0 blue:80/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"ground"] ) {
        return [UIColor colorWithRed:110/255.0 green:73/255.0 blue:31/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"ice"] ) {
        return [UIColor colorWithRed:133/255.0 green:210/255.0 blue:245/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"normal"] ) {
        return [UIColor colorWithRed:117/255.0 green:82/255.0 blue:92/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"poison"] ) {
        return [UIColor colorWithRed:134/255.0 green:211/255.0 blue:40/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"psychic"] ) {
        return [UIColor colorWithRed:247/255.0 green:29/255.0 blue:146/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"rock"] ) {
        return [UIColor colorWithRed:72/255.0 green:25/255.0 blue:11/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"steel"] ) {
        return [UIColor colorWithRed:96/255.0 green:117/255.0 blue:110/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"water"] ) {
        return [UIColor colorWithRed:21/255.0 green:82/255.0 blue:225/255.0 alpha:1];
    }
    
    // Creatures
    if ([self.pokemon.type isEqualToString:@"bug"] ) {
        return [UIColor colorWithRed:28/255.0 green:75/255.0 blue:39/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"dragon"] ) {
        return [UIColor colorWithRed:67/255.0 green:138/255.0 blue:149/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"fairy"] ) {
        return [UIColor colorWithRed:233/255.0 green:20/255.0 blue:104/255.0 alpha:1];
    } else if ([self.pokemon.type isEqualToString:@"ghost"] ) {
        return [UIColor colorWithRed:144/255.0 green:104/255.0 blue:144/255.0 alpha:1];
    }
    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"sprite"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self configureView];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemon addObserver:self forKeyPath:@"sprite" options:0 context:nil];
    [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
    [self configureView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.pokemon removeObserver:self forKeyPath:@"sprite"];
}

@end
