

@class Taskit;
@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic, strong) Taskit *p2psip, *rtmplite;
@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSDictionary *cities;

@end
