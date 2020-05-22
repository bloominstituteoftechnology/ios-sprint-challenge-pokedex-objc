# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

  ```swift
  NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
  
  NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain]; // this is retained but never released
  
  NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
  NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
  
  NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init]; // need to release this
  
  for (NSString *word in words) { // we are allocating in a tight loop here
      @autoreleasepool {
          NSNumber *count = wordFrequency[word];
          if (count) {
              wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
          } else {
              wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease]; // need to release this
          }
      }
  }
  
  printf("Word frequency: %s", wordFrequency.description.UTF8String);
  
  [punctuationSet release];
  [wordFrequency release];
  ```

  2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date]; // This one: it is a convenience method`
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];// Would be, but isn't because it is retained`
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	
	4. `NSDate *food = [NSDate new];`
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease]; // This one, explicitly autoreleased`

3. Explain when you need to use the `NSAutoreleasePool`.

   You need to use the autorelease pool when in a tight loop where the runloop normally won't get a chance to release objects because the loop prevents it from doing so


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
+ (instancetype)personWithName(NSString *)name;

@end
@implementation
+ (instancetype)personWithName(NSString *)name {
  return [[[self alloc] initWithName:name] autorelease];
}
@end
```
