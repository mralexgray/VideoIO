
#import "AppDelegate.h"


@implementation AppDelegate

- (void)applicationWillTerminate:(NSNotification *)notification {  AZLOG(@"Trying to stop !"); }

- (void)awakeFromNib
{
	AZSimpleView *ss = (AZSimpleView*)(_window.contentView = [AZSimpleView.alloc initWithFrame:_window.frame]);
	[ss setBackgroundColor:LINEN];
	[ss addSubview:[BNRBlockView viewWithFrame:AZRectFromSize(_window.frame.size) opaque:YES drawnUsingBlock:^(BNRBlockView *view, NSR dirtyRect) {
//		CAL*l = [view setupHostView];// l.position = AZCenter(dirtyRect);
//		l.anchorPoint = (CGP){1,1};
//		[l animate:@"transform.scale" fromFloat:0 to:1 time:10	eased: CAMEDIAEASEIN];
//		l.backgroundColor = cgRED; [l addConstraintsSuperSize];
//		l.arMASK = CASIZEABLE;
//		l.needsDisplayOnBoundsChange = YES;
//		if (l.sublayers.count == 0)
		[[NSA from:0 to:3] each:^(id obj) {
			[view addSubview:[AZSimpleView withFrame:quadrant( dirtyRect,[obj integerValue]) color:RANDOMCOLOR]]; //[[CAL layerWithFrame: quadrant( dirtyRect,i)]colored:RANDOMCOLOR];// named:obj];
		}];
	}]];

	[NSThread performBlockInBackground:^{

		
		self.sipd = [self sipd];
		AZLOG(_sipd.propertiesPlease);
		if (_sipd.terminationStatus != 0) {
			NSLog(@"Properlem launching SIP");
		} else  	[NSThread performBlockInBackground:^{
			self.rtmplite = [self rtmplite];
				NSLog(@"RTMP %@", _rtmplite.propertiesPlease);
		}];
	}];

}



//cd p2p-sip-read-only/src	$ PYTHONPATH=app:external:.		//$ export PYTHONPATH	//$ python app/sipd.py -d
- (NSTask*)rtmplite {	 _rtmplite = NSTask.new;	_rtmplite.standardOutput = AZNEWPIPE; 	_rtmplite.standardError	 = AZNEWPIPE;

			  setenv 				("PYTHONPATH", "../p2p-sip/src:.", 1);
	_rtmplite.launchPath			= @"/usr/bin/python";
	_rtmplite.arguments				= @[ @"siprtmp.py", @"-d"];
	_rtmplite.currentDirectoryPath 	= [AZAPPRESOURCES withPath:@"rtmplite"];	 return launchMonitorAndReturnTask(_rtmplite);

}


- (NSTask*)sipd {	 _sipd = NSTask.new;	_sipd.standardOutput = AZNEWPIPE; 	_sipd.standardError	 = AZNEWPIPE;

		  setenv 				("PYTHONPATH", "app:external:.", 1);
	_sipd.launchPath			= @"/usr/bin/python";
	_sipd.arguments				= @[ @"app/sipd.py", @"-d"];
	_sipd.currentDirectoryPath 	= [AZAPPRESOURCES withPath:@"p2p-sip/src"];	 return launchMonitorAndReturnTask(_sipd);
}


- (void) applicationDidFinishLaunching:(NSNotification *)notification
{
	[AZUSERDEFS setInteger:AZPROCINFO.processIdentifier forKey:@"PID"]; 		// get parent PID (this app) to pass to watchdog
	AZLOG(AZPROCINFO);

}
@end

//		NSBundle *mainBundle = [NSBundle mainBundle];
//		NSString *resourcePath = [mainBundle resourcePath];
//		NSArray *pythonPathArray = [NSArray arrayWithObjects: resourcePath, [resourcePath stringByAppendingPathComponent:@"python"], nil];
//	@[@"app/sipd.py",@"-d"]
/**		NSString *resourcePath = [[NSBundle.mainBundle resourcePath]stringByAppendingPathComponent:@"p2p-sip/src"];
//			 @{ @"PYTHONPATH" : @"app:external:." }];

		setenv("PYTHONPATH", "app:external:.", 1);//[[pythonPathArray componentsJoinedByString:@":"] UTF8String], 1);

		Py_SetProgramName("/usr/bin/python");

	Py_Initialize();
	PyRun_SimpleString("import urllib"\
"import re"\
"f = urllib.urlopen('http://www.canyouseeme.org/')"\
"html_doc = f.read()"\
"f.close()"\
"m = re.search('(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)',html_doc)"\
"print m.group(0)");

*/
//		PySys_SetArgv(argc, (char *´*)argv);
		
//		const char *mainFilePathPtr = [ UTF8String];
//		FILE *mainFile = fopen(mainFilePathPtr, "r");
//		int result = PyRun_SimpleFile(mainFile, (char *)[[mainFilePath lastPathComponent] UTF8String]);

//		if ( result != 0 )
//			[NSException raise: NSInternalInconsistencyException
//						format: @"%s:%d main() PyRun_SimpleFile failed with file '%@'.  See console for errors.", __FILE__, __LINE__, mainFilePath];
//
//	}];
//	[self checkWeather];
//	[self startSIP];

	/*	self.p2psip = [CWTask.alloc initWithExecutable: @"/usr/bin/python"
	 andArguments:	@[@"app/sipd.py",@"-d"]
	 atDirectory: [[NSBundle.mainBundle resourcePath]stringByAppendingPathComponent:@"p2p-sip/src"]
	 withEnvironment: @{ @"PYTHONPATH" : @"app:external:." }];
	 */
//	 [NSThread performBlockInBackground:^{
/**
//		[self.shell launch];
//		[_shell waitUntilExit];

		NSData *epipe = [[_shell.standardError fileHandleForReading] readDataToEndOfFile];
		char* buffer;
		if ([epipe length] > 0)
		{
			buffer = calloc([epipe length]+1, sizeof(char));
			[epipe getBytes:buffer length:[epipe length]];
			NSString *edesc = @(buffer);
			NSAlert  *alert =
			[NSAlert alertWithMessageText:NSLocalizedString(@"run error",
															@"") defaultButton:@"OK" alternateButton:nil otherButton:nil
				informativeTextWithFormat:[edesc description]];
			[alert runModal];
			free(buffer);
			return;
		}

		NSData   *spipe      = [[_shell.standardOutput fileHandleForReading] readDataToEndOfFile];
		buffer = calloc([spipe length]+1, sizeof(char));
		[spipe getBytes:buffer length:[spipe length]];
		NSString *resultText = @(buffer);

		NSLog(@"%@", resultText);

//	}];

//	[outputdescription selectAll:nil];
//	NSRange start = [outputdescription selectedRange];
//	NSRange end   = NSMakeRange(start.length, 0);
//	[outputdescription setSelectedRange:end];
//	[outputdescription insertText:resultText];
//	free(buffer);


	self.p2psip = [CWTask.alloc initWithExecutable: @"/bin/ls"
									  andArguments:	@[@"/git",@"-lar"]
									   atDirectory: [[NSBundle.mainBundle resourcePath]stringByAppendingPathComponent:@"p2p-sip/src"]
								   withEnvironment: nil];//@{ @"PYTHONPATH" : @"app:external:." }];

	[p2psip launchTaskWithResult:^(NSString *output, NSError *error) {
		NSLog(@"Result:  %@  Error: %@", output, error);
	}];
	//	NSError *e;
	//    [p2psip launchTask:&e];
	//	NSLog(@"error:  %@", e);

	// = ^void(NSString *output) {	NSLog(@"%@", output);    };

	//    [p2psip launch];
*/

//
//-(void) startSIP {
//
//	NSPipe *stdOutPipe, *stdErrPipe;	stdOutPipe = NSPipe.pipe; stdErrPipe = NSPipe.pipe;
//	NSTask* task 			= NSTask.new;
//	task.launchPath	 		= @"/usr/bin/python";
//	NSString *p = [[[NSBundle.mainBundle resourcePath]withPath:@"p2p-sip"]withPath:@"src"];
//	NSLog(@"scriptpath: %@", p);
//	task.currentDirectoryPath = p;
//
//	NSMutableDictionary *i = NSMD.dictionary;
//	[i addEntriesFromDictionary:[NSProcessInfo.processInfo environment]];
//	[i addEntriesFromDictionary:@{ @"PYTHONPATH" : @"app:external:." }];
//	//	task.environment = i.copy;
//	NSLog(@"%@", task.environment);
//	task.environment		= @{ @"PYTHONPATH" : @"app:external:." };
//	task.arguments 			= @[@"app/sipd.py",@"-d"];
//
//	//	task.standardInput		= NSPipe.pipe;	// NSLog breaks if we don't do this...
//	task.standardOutput 	= stdOutPipe;
//	//	task.standardError		= stdErrPipe;
//	[task launch];
//	NSData* data = [[stdOutPipe fileHandleForReading] readDataToEndOfFile];
//
//	[task waitUntilExit];
//
//	NSInteger exitCode = task.terminationStatus;
//	NSS *u =  exitCode != 0 	? [NSString.alloc initWithFormat:@"Error!  %ld", exitCode]
//	: [NSString.alloc initWithBytes: data.bytes length:data.length encoding: NSUTF8StringEncoding];
//	NSLog(@"u:%@", u);
//}

//cd p2p-sip-read-only/src
//$ PYTHONPATH=app:external:.
//$ export PYTHONPATH
//$ python app/sipd.py -d
//On second terminal, download rtmplite and run its siprtmp module as follows. This will run siprtmp on port 1935 by default.
//
//$ svn checkout http://rtmplite.googlecode.com/svn/trunk/ rtmplite-read-only
//$ cd rtmplite-read-only
//$ PYTHONPATH=../p2p-sip-read-only/src:.
//$ export PYTHONPATH
//$ python siprtmp.py -d


/*
- (NSString*)weatherForCity:(NSString*)city
{
	NSPipe *stdOutPipe, *stdErrPipe;
	NSTask* task 			= NSTask.new;
	task.launchPath	 		= @"/usr/bin/python";
	NSString *scriptPath 	= [NSBundle.mainBundle pathForResource:@"weather" ofType:@"py"];
	task.arguments 			= @[scriptPath, [_cities[city] stringValue]];
	task.standardInput		= NSPipe.pipe;	// NSLog breaks if we don't do this...
	stdOutPipe				= NSPipe.pipe;
	stdErrPipe				= NSPipe.pipe;
	task.standardOutput 	= stdOutPipe;
	task.standardError		= stdErrPipe;
	//	NSLog(@"Task: %@", task);
	[task launch];
	NSData* data = [[stdOutPipe fileHandleForReading] readDataToEndOfFile];
	[task waitUntilExit];

	NSInteger exitCode = task.terminationStatus;
	return  exitCode != 0 	? [NSString.alloc initWithFormat:@"Error!  %ld", exitCode]
	: [NSString.alloc initWithBytes: data.bytes length:data.length encoding: NSUTF8StringEncoding];
}

- (void)checkWeather
{
	dispatch_group_t group = dispatch_group_create();
	NSMutableArray* results = NSMutableArray.new;
	dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[_cities.allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			NSMutableString* result = [self weatherForCity:obj].mutableCopy;
			[result replaceCharactersInRange:(NSRange){result.length -2,2} withString:@""];
			@synchronized(results)
			{
				if (result) [results addObject:  [NSString stringWithFormat:@"Weather for:%@  %@", obj, result]];
			}
		}];
	});

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self scriptsDidFinishWithResults: results];
    });
}

- (void) scriptsDidFinishWithResults: (NSArray*)results
{
	NSLog(@"%@", results);
}

*/

