# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```
	2. Rewrite the code so that it does not leak any memory with ARC disabled

"""
NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autoRelease];    i added autorelease, because the instead of having to rely on remembering to release the object id rather let the                                                                                                                                                                                                      system do that on its own accord right after the method is done running. and also that way the system doesnt store the object in memory 

for (NSString *word in words) {
    NSNumber *count = wordFrequency[word];
    if (count) {
        wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
    } else {
        wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
    }
}

printf("Word frequency: %s", wordFrequency.description.UTF8String);
[[ self  punctuationSet] release ];                                                                     i did a release since the punctiationSet was retained we need to release it after its no longer needed.
"""
2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
    since we dont own this object we must not release it.. its possible to retain it therefore making us the owner of the object and making us repsonsible for releasing it later on.
    
        NSdate *today = [[NSDAte alloc] init]  // we now own the object so we are responsible for releasing it once its no longer needed
        
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
        this object is retained so it needs be manually released
    
        [theFuture release];
        
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	name is initialized therefore we own it and we are responsible to release it and since the autoRelease method isnt being called we need to manually release it, it is possible to implememnt autorelease 
    
    NSString *name = [[[NSString alloc] initWithString:@"John Sundell"] autorelease];
    now the object will be released once the system is done with it
    
	4. `NSDate *food = [NSDate new];`
	we are neither initialing, allocating, but it is new therefore we own it, and are responsible to release it. 
    
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    initialized therefore we own it and we are responsible to release it and since autoRelease isnt being called we need to manually release it 
    
    [john release]
    
     it is possible to implememnt autorelease 
    LSIPerson *john = [[[LSIPerson alloc] initWithName:name]autoRelease];`

	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
        this object has the autorelease method called on it.

NSobjects have a form of autoreleasing/releasing once they're no longer being used however if we retain it we manually have to release it once we're done with the object..
autorelease only works if its called when we are initalizing an object, ex: NSString *name = [[NSString alloc] init] autorelease];


3. Explain when you need to use the `NSAutoreleasePool`.
//  the autorelease needs to be declared when an object is created if we want the system to release it after the method is done using the object ex [[NSArray alloc] init] autoRelease] 

i would use the NSAutoReleasepool in a for loop since it is possible to iterate of mutiple values and have that information being store without it being later on released 

ex.  for (NSinteger i = 0; i < 1000; i++;) {
NSAutoReleasePool * pool = [[NSautoReleasePool alloc] init];
BigObject big = [BigObject BbigObject];
[pool drain]
}


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;


- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [[name new] autorelease];
    }
    return self;

@end
```

