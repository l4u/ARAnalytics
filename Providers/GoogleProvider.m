//
//  GoogleProvider.m
//  ARAnalyticsTests
//
//  Created by orta therox on 05/01/2013.
//  Copyright (c) 2013 Orta Therox. All rights reserved.
//

#import "GoogleProvider.h"

@implementation GoogleProvider
#ifdef AR_GOOGLEANALYTICS_EXISTS

- (id)initWithIdentifier:(NSString *)identifier {
    NSAssert([GAI class], @"Google Analytics SDK is not included");
    [[GAI sharedInstance] trackerWithTrackingId:identifier];

    self = [super init];
    return self;
}

- (void)identifyUserwithID:(NSString *)id andEmailAddress:(NSString *)email {
    // Not allowed in GA
    // https://developers.google.com/analytics/devguides/collection/ios/v2/customdimsmets#pii

    // The Google Analytics Terms of Service prohibit sending of any personally identifiable information (PII) to Google Analytics servers. For more information, please consult the Terms of Service.
}

- (void)setUserProperty:(NSString *)property toValue:(NSString *)value {
    [[[GAI sharedInstance] defaultTracker] set:property value:value];
}

- (void)event:(NSString *)event withProperties:(NSDictionary *)properties {
    [[[GAI sharedInstance] defaultTracker] trackEventWithCategory:nil withAction:event withLabel:nil withValue:nil];
}

- (void)didShowNewViewController:(UIViewController *)controller {
    [self event:@"Screen view" withProperties:@{ @"screen": controller.title }];
    [[[GAI sharedInstance] defaultTracker] trackView:controller.title];
}

- (void)logTimingEvent:(NSString *)event withInterval:(NSNumber *)interval {
    [self event:event withProperties:@{ @"length": interval }];

    [[[GAI sharedInstance] defaultTracker] trackTimingWithCategory:nil withValue:interval.doubleValue withName:event withLabel:nil];
}

#endif
@end
