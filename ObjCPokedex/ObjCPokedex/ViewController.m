//
//  ViewController.m
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/22/21.
//

#import "ViewController.h"
#import "Pokemon.h"
#import "ObjCPokedex-Bridging-Header.h"
#import "ObjCPokedex-Swift.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImageView;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak, nonatomic) IBOutlet UILabel *pokemonID;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbility;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
