#import "CCVibrate.h"

@implementation CCVibrate

//Return the icon of your module here
- (UIImage *)iconGlyph
{
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

//Return the color selection color of your module here
- (UIColor *)selectedColor
{
	return [UIColor blackColor];
}

- (BOOL)isSelected
{
	CFPropertyListRef CFSilent = CFPreferencesCopyAppValue(CFSTR("silent-vibrate"), CFSTR("com.apple.springboard"));
  	CFPropertyListRef CFRing = CFPreferencesCopyAppValue(CFSTR("ring-vibrate"), CFSTR("com.apple.springboard"));
  	_selected = CFBooleanGetValue((CFBooleanRef)CFSilent) && CFBooleanGetValue((CFBooleanRef)CFRing);

  	return _selected;
}

- (void)setSelected:(BOOL)selected
{
	_selected = selected;
	[super refreshState];
	
	NSString *sbPath = @"/var/mobile/Library/Preferences/com.apple.springboard.plist";
  	NSMutableDictionary *prefsDict = [[NSMutableDictionary alloc] initWithContentsOfFile:sbPath];

  	[prefsDict setObject:[NSNumber numberWithBool:selected] forKey:@"silent-vibrate"];
	[prefsDict setObject:[NSNumber numberWithBool:selected] forKey:@"ring-vibrate"];
	[prefsDict writeToFile:sbPath atomically:YES];

  	CFPreferencesSetAppValue(CFSTR("silent-vibrate"), selected ? kCFBooleanTrue : kCFBooleanFalse, CFSTR("com.apple.springboard"));
	CFPreferencesSetAppValue(CFSTR("ring-vibrate"), selected ? kCFBooleanTrue : kCFBooleanFalse, CFSTR("com.apple.springboard"));

  	CFPreferencesAppSynchronize(CFSTR("com.apple.springboard"));
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.apple.springboard.silent-vibrate.changed"), NULL, NULL, TRUE);
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.apple.springboard.ring-vibrate.changed"), NULL, NULL, TRUE);
}

@end
