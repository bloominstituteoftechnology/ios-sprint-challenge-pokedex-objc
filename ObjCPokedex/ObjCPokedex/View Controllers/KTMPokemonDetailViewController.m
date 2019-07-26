//
//  KTMPokemonDetailViewController.m
//  ObjCPokedex
//
//  Created by Kobe McKee on 7/26/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

#import "KTMPokemonDetailViewController.h"
#import "KTMPokemon.h"
#import "ObjCPokedex-Swift.h"

void *KVOContext = &KVOContext;

@interface KTMPokemonDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextView *abilitiesTextView;
@end

@implementation KTMPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setPokemon:(KTMPokemon *)pokemon {
    if (pokemon != _pokemon) {
        _pokemon = pokemon;
        [self.pokemon addObserver:self forKeyPath:@"abilities" options:NSKeyValueObservingOptionInitial context:KVOContext];
    }
}


- (void)updateViews {
    if (self.viewLoaded || self.pokemon) {
        self.nameLabel.text = self.pokemon.name;
        self.idLabel.text = [NSString stringWithFormat:@"ID: %@", self.pokemon.identifier];
        
        NSString *abilitiesString = [self.pokemon.abilities componentsJoinedByString:@" \n"];
        self.abilitiesTextView.text = abilitiesString;
        
        [self fetchSprite];
    }
}

- (void)fetchSprite {
    NSURL *spriteURL = self.pokemon.spriteURL;
    NSLog(@"%@", spriteURL.absoluteString);
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:spriteURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching sprite: %@", error);
            return;
        }
        
        if (!data) {
            NSLog(@"No data returned for sprite");
            return;
        }
        
        UIImage *sprite = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:sprite];
        });
    }];
    [dataTask resume];
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == KVOContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateViews];
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self.pokemon removeObserver:self forKeyPath:@"abilities" context:&KVOContext];
}



@end
