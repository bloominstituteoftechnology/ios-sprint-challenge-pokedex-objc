//
//  BTPokemonDetailViewController.m
//  PokeDex
//
//  Created by Bohdan Tkachenko on 12/12/20.
//

#import "BTPokemonDetailViewController.h"
#import "BTPokemon.h"
#import "PokeDex-Swift.h"

void *BTContext = &BTContext;

@interface BTPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *abilitiesLabel;

@end

@implementation BTPokemonDetailViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController fillInDetailsFor:self.pokemon];
    [self.pokemon addObserver:self forKeyPath:@"identifier" options:0 context:BTContext];
    [self.pokemon addObserver:self forKeyPath:@"abilitiesArray" options:0 context:BTContext];
    [self.pokemon addObserver:self forKeyPath:@"image" options:0 context:BTContext];
}


#pragma mark - Functions

-(void)updateViews {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.title = self.pokemon.name.capitalizedString;
        
        self.nameLabel.text = self.pokemon.name.capitalizedString;
        self.idLabel.text = [[NSString alloc] initWithFormat:@"%@", self.pokemon.identifier];
        
        NSString *stringOfAbilities = [self.pokemon.abilitiesArray componentsJoinedByString:@"\n"];
        
        self.abilitiesLabel.text = [[NSString alloc]initWithFormat: @"%@", stringOfAbilities];
    });
}

- (void)downloadImageWithURL:(NSURL *)url {
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", url);
        
        if (error) {
            NSLog(@"Error downloading image: %@", error);
        }
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
    
    [task resume];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == BTContext) {
        if ([keyPath isEqualToString:@"identifier"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"abilitiesArray"]) {
            [self updateViews];
        } else if ([keyPath isEqualToString:@"image"]) {
            [self downloadImageWithURL:self.pokemon.image];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:@"identifier" context:BTContext];
    [self.pokemon removeObserver:self forKeyPath:@"abilitiesArray" context:BTContext];
    [self.pokemon removeObserver:self forKeyPath:@"image" context:BTContext];
}

@end
