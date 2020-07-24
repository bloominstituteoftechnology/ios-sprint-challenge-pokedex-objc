//
//  AppDelegate.h
//  Pokedex
//
//  Created by Vincent Hoang on 7/24/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

