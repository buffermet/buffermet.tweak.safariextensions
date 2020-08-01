/*
#import <CFNetwork/CFNetwork-Structs.h>
#import <CFNetwork/NSURLRequest.h>
@class NSString, NSDictionary, NSData, NSInputStream, NSURL;
@interface NSMutableURLRequest : NSURLRequest
@property (copy) NSString * HTTPMethod; 
@property (copy) NSDictionary * allHTTPHeaderFields; 
@property (copy) NSData * HTTPBody; 
@property (retain) NSInputStream * HTTPBodyStream; 
@property (assign) BOOL HTTPShouldHandleCookies; 
@property (assign) BOOL HTTPShouldUsePipelining; 
@property (copy) NSURL * URL; 
@property (assign) unsigned long long cachePolicy; 
@property (assign) double timeoutInterval; 
@property (copy) NSURL * mainDocumentURL; 
@property (assign) unsigned long long networkServiceType; 
@property (assign) BOOL allowsCellularAccess; 
-(void)setMainDocumentURL:(NSURL *)arg1 ;
-(void)_setPreventHSTSStorage:(BOOL)arg1 ;
-(void)setHTTPContentType:(id)arg1 ;
-(void)setHTTPExtraCookies:(id)arg1 ;
-(void)setHTTPReferrer:(id)arg1 ;
-(void)setHTTPUserAgent:(id)arg1 ;
-(void)setExpectedWorkload:(unsigned long long)arg1 ;
-(void)_setTimeWindowDelay:(double)arg1 ;
-(void)_setTimeWindowDuration:(double)arg1 ;
-(void)_setStartTimeoutDate:(id)arg1 ;
-(void)_setRequiresShortConnectionTimeout:(BOOL)arg1 ;
-(void)_setPayloadTransmissionTimeout:(double)arg1 ;
-(void)setContentDispositionEncodingFallbackArray:(id)arg1 ;
-(void)setCachePolicy:(unsigned long long)arg1 ;
-(void)setHTTPShouldHandleCookies:(BOOL)arg1 ;
-(void)setValue:(id)arg1 forHTTPHeaderField:(id)arg2 ;
-(void)setAllowsCellularAccess:(BOOL)arg1 ;
-(void)setHTTPMethod:(NSString *)arg1 ;
-(void)setHTTPBody:(NSData *)arg1 ;
-(unsigned long long)requestPriority;
-(void)setRequestPriority:(unsigned long long)arg1 ;
-(void)addValue:(id)arg1 forHTTPHeaderField:(id)arg2 ;
-(void)setBoundInterfaceIdentifier:(id)arg1 ;
-(void)_setIgnoreHSTS:(BOOL)arg1 ;
-(void)setHTTPShouldUsePipelining:(BOOL)arg1 ;
-(void)setAllHTTPHeaderFields:(NSDictionary *)arg1 ;
-(void)setNetworkServiceType:(unsigned long long)arg1 ;
-(void)setHTTPBodyStream:(NSInputStream *)arg1 ;
-(void)setTimeoutInterval:(double)arg1 ;
-(id)copyWithZone:(NSZone*)arg1 ;
-(void)setURL:(NSURL *)arg1 ;
@end

#import <WebKit/WebKit-Structs.h>
#import <UIKitCore/UIView.h>
#import <UIKit/UIScrollViewDelegate.h>
#import <UIKit/UIResponderStandardEditActions.h>
@class WKBrowsingContextHandle, NSURL, NSArray, NSString, NSData, _WKSessionState, UIView, _WKWebViewPrintFormatter, NSNumber, _WKInspector, _WKFrameHandle, WKPasswordView, WKWebViewContentProviderRegistry, WKWebViewConfiguration, WKBackForwardList, UIScrollView;
@interface WKWebView : UIView <UIScrollViewDelegate, UIResponderStandardEditActions> {
	RetainPtr<WKWebViewConfiguration>* _configuration;
	RefPtr<WebKit::WebPageProxy, WTF::DumbPtrTraits<WebKit::WebPageProxy> >* _page;
	unique_ptr<WebKit::NavigationState, std::__1::default_delete<WebKit::NavigationState> >* _navigationState;
	unique_ptr<WebKit::UIDelegate, std::__1::default_delete<WebKit::UIDelegate> >* _uiDelegate;
	unique_ptr<WebKit::IconLoadingDelegate, std::__1::default_delete<WebKit::IconLoadingDelegate> >* _iconLoadingDelegate;
	unsigned long long _observedRenderingProgressEvents;
	WeakObjCPtr<id<_WKInputDelegate> > _inputDelegate;
	Optional<bool> _resolutionForShareSheetImmediateCompletionForTesting;
	RetainPtr<WKSafeBrowsingWarning>* _safeBrowsingWarning;
	BOOL _usePlatformFindUI;
	RetainPtr<_WKRemoteObjectRegistry>* _remoteObjectRegistry;
	RetainPtr<WKScrollView>* _scrollView;
	RetainPtr<WKContentView>* _contentView;
	RetainPtr<WKFullScreenWindowController>* _fullScreenWindowController;
	Optional<CGSize> _viewLayoutSizeOverride;
	Optional<WebCore::FloatSize> _lastSentViewLayoutSize;
	Optional<CGSize> _maximumUnobscuredSizeOverride;
	Optional<WebCore::FloatSize> _lastSentMaximumUnobscuredSize;
	CGRect _inputViewBounds;
	double _viewportMetaTagWidth;
	BOOL _viewportMetaTagWidthWasExplicit;
	BOOL _viewportMetaTagCameFromImageDocument;
	double _initialScaleFactor;
	BOOL _fastClickingIsDisabled;
	BOOL _allowsLinkPreview;
	UIEdgeInsets _obscuredInsets;
	BOOL _haveSetObscuredInsets;
	BOOL _isChangingObscuredInsetsInteractively;
	UIEdgeInsets _unobscuredSafeAreaInsets;
	BOOL _haveSetUnobscuredSafeAreaInsets;
	BOOL _avoidsUnsafeArea;
	unsigned long long _obscuredInsetEdgesAffectedBySafeArea;
	long long _interfaceOrientationOverride;
	BOOL _overridesInterfaceOrientation;
	Optional<int> _lastSentDeviceOrientation;
	BOOL _allowsViewportShrinkToFit;
	BOOL _hasCommittedLoadForMainFrame;
	BOOL _needsResetViewStateAfterCommitLoadForMainFrame;
	unsigned long long _firstPaintAfterCommitLoadTransactionID;
	int _dynamicViewportUpdateMode;
	unsigned long long _currentDynamicViewportSizeUpdateID;
	CATransform3D _resizeAnimationTransformAdjustments;
	double _animatedResizeOriginalContentWidth;
	RetainPtr<UIView>* _resizeAnimationView;
	double _lastAdjustmentForScroller;
	Optional<CGRect> _frozenVisibleContentRect;
	Optional<CGRect> _frozenUnobscuredContentRect;
	BOOL _commitDidRestoreScrollPosition;
	Optional<WebCore::FloatPoint> _scrollOffsetToRestore;
	RectEdges<float> _obscuredInsetsWhenSaved;
	Optional<WebCore::FloatPoint> _unobscuredCenterToRestore;
	Optional<unsigned long long> _firstTransactionIDAfterPageRestore;
	double _scaleToRestore;
	unique_ptr<WebKit::ViewGestureController, std::__1::default_delete<WebKit::ViewGestureController> >* _gestureController;
	BOOL _allowsBackForwardNavigationGestures;
	RetainPtr<UIView<WKWebViewContentProvider> >* _customContentView;
	RetainPtr<UIView>* _customContentFixedOverlayView;
	RetainPtr<NSTimer>* _enclosingScrollViewScrollTimer;
	BOOL _didScrollSinceLastTimerFire;
	Color* _scrollViewBackgroundColor;
	double _totalScrollViewBottomInsetAdjustmentForKeyboard;
	BOOL _currentlyAdjustingScrollViewInsetsForKeyboard;
	BOOL _delayUpdateVisibleContentRects;
	BOOL _hadDelayedUpdateVisibleContentRects;
	BOOL _waitingForEndAnimatedResize;
	BOOL _waitingForCommitAfterAnimatedResize;
	Vector<WTF::Function<void ()>, 0, WTF::CrashOnOverflow, 16>* _callbacksDeferredDuringResize;
	RetainPtr<NSMutableArray>* _stableStatePresentationUpdateCallbacks;
	RetainPtr<WKPasswordView>* _passwordView;
	BOOL _hasScheduledVisibleRectUpdate;
	BOOL _visibleContentRectUpdateScheduledFromScrollViewInStableState;
	Vector<WTF::BlockPtr<void ()>, 0, WTF::CrashOnOverflow, 16>* _visibleContentRectUpdateCallbacks;
	unsigned long long _dragInteractionPolicy;
	MonotonicTime _timeOfRequestForVisibleContentRectUpdate;
	MonotonicTime _timeOfLastVisibleContentRectUpdate;
	unsigned long long _focusPreservationCount;
	unsigned long long _activeFocusedStateRetainCount;
	unsigned long long _selectionAttributes;
}
@property (nonatomic,readonly) id _remoteObjectRegistry; 
@property (nonatomic,readonly) WKBrowsingContextHandle * _handle; 
@property (assign,setter=_setObservedRenderingProgressEvents:,nonatomic) unsigned long long _observedRenderingProgressEvents; 
@property (assign,setter=_setHistoryDelegate:,nonatomic,__weak) id<WKHistoryDelegatePrivate> _historyDelegate; 
@property (assign,setter=_setIconLoadingDelegate:,nonatomic,__weak) id<_WKIconLoadingDelegate> _iconLoadingDelegate; 
@property (nonatomic,readonly) NSURL * _unreachableURL; 
@property (nonatomic,readonly) NSURL * _mainFrameURL; 
@property (nonatomic,readonly) NSArray * _certificateChain; 
@property (nonatomic,readonly) NSURL * _committedURL; 
@property (nonatomic,readonly) NSString * _MIMEType; 
@property (nonatomic,readonly) NSString * _userAgent; 
@property (getter=_isPlayingAudio,nonatomic,readonly) BOOL _playingAudio; 
@property (setter=_setApplicationNameForUserAgent:,copy) NSString * _applicationNameForUserAgent; 
@property (setter=_setCustomUserAgent:,copy) NSString * _customUserAgent; 
@property (assign,setter=_setUserContentExtensionsEnabled:,nonatomic) BOOL _userContentExtensionsEnabled; 
@property (nonatomic,readonly) int _webProcessIdentifier; 
@property (nonatomic,readonly) int _provisionalWebProcessIdentifier; 
@property (assign,setter=_setEditable:,getter=_isEditable,nonatomic) BOOL _editable; 
@property (nonatomic,readonly) NSData * _sessionStateData; 
@property (nonatomic,readonly) _WKSessionState * _sessionState; 
@property (assign,setter=_setAllowsRemoteInspection:,nonatomic) BOOL _allowsRemoteInspection; 
@property (setter=_setRemoteInspectionNameOverride:,nonatomic,copy) NSString * _remoteInspectionNameOverride; 
@property (assign,setter=_setAddsVisitedLinks:,nonatomic) BOOL _addsVisitedLinks; 
@property (nonatomic,readonly) BOOL _networkRequestsInProgress; 
@property (getter=_isShowingNavigationGestureSnapshot,nonatomic,readonly) BOOL _showingNavigationGestureSnapshot; 
@property (nonatomic,readonly) NSURL * _resourceDirectoryURL; 
@property (assign,setter=_setLayoutMode:,nonatomic) unsigned long long _layoutMode; 
@property (assign,setter=_setFixedLayoutSize:,nonatomic) CGSize _fixedLayoutSize; 
@property (assign,setter=_setViewportSizeForCSSViewportUnits:,nonatomic) CGSize _viewportSizeForCSSViewportUnits; 
@property (assign,setter=_setViewScale:,nonatomic) double _viewScale; 
@property (assign,setter=_setMinimumEffectiveDeviceWidth:,nonatomic) double _minimumEffectiveDeviceWidth; 
@property (assign,setter=_setBackgroundExtendsBeyondPage:,nonatomic) BOOL _backgroundExtendsBeyondPage; 
@property (nonatomic,readonly) unsigned long long _selectionAttributes; 
@property (nonatomic,readonly) CGSize _minimumLayoutSizeOverride; 
@property (nonatomic,readonly) CGSize _maximumUnobscuredSizeOverride; 
@property (assign,setter=_setObscuredInsets:,nonatomic) UIEdgeInsets _obscuredInsets; 
@property (assign,setter=_setUnobscuredSafeAreaInsets:,nonatomic) UIEdgeInsets _unobscuredSafeAreaInsets; 
@property (nonatomic,readonly) BOOL _safeAreaShouldAffectObscuredInsets; 
@property (assign,setter=_setObscuredInsetEdgesAffectedBySafeArea:,nonatomic) unsigned long long _obscuredInsetEdgesAffectedBySafeArea; 
@property (nonatomic,readonly) UIView * _enclosingViewForExposedRectComputation; 
@property (assign,setter=_setInterfaceOrientationOverride:,nonatomic) long long _interfaceOrientationOverride; 
@property (assign,setter=_setAllowsViewportShrinkToFit:,nonatomic) BOOL _allowsViewportShrinkToFit; 
@property (getter=_isDisplayingPDF,nonatomic,readonly) BOOL _displayingPDF; 
@property (nonatomic,readonly) NSData * _dataForDisplayedPDF; 
@property (nonatomic,readonly) NSString * _suggestedFilenameForDisplayedPDF; 
@property (nonatomic,readonly) _WKWebViewPrintFormatter * _webViewPrintFormatter; 
@property (assign,setter=_setDragInteractionPolicy:,nonatomic) unsigned long long _dragInteractionPolicy; 
@property (nonatomic,readonly) BOOL _shouldAvoidResizingWhenInputViewBoundsChange; 
@property (nonatomic,readonly) UIView * _safeBrowsingWarning; 
@property (assign,setter=_setPaginationMode:,nonatomic) long long _paginationMode; 
@property (assign,setter=_setPaginationBehavesLikeColumns:,nonatomic) BOOL _paginationBehavesLikeColumns; 
@property (assign,setter=_setPageLength:,nonatomic) double _pageLength; 
@property (assign,setter=_setGapBetweenPages:,nonatomic) double _gapBetweenPages; 
@property (assign,setter=_setPaginationLineGridEnabled:,nonatomic) BOOL _paginationLineGridEnabled; 
@property (readonly) unsigned long long _pageCount; 
@property (nonatomic,readonly) BOOL _supportsTextZoom; 
@property (assign,setter=_setTextZoomFactor:,nonatomic) double _textZoomFactor; 
@property (assign,setter=_setPageZoomFactor:,nonatomic) double _pageZoomFactor; 
@property (assign,setter=_setDiagnosticLoggingDelegate:,nonatomic,__weak) id<_WKDiagnosticLoggingDelegate> _diagnosticLoggingDelegate; 
@property (assign,setter=_setFindDelegate:,nonatomic,__weak) id<_WKFindDelegate> _findDelegate; 
@property (assign,setter=_setInputDelegate:,nonatomic,__weak) id<_WKInputDelegate> _inputDelegate; 
@property (getter=_isDisplayingStandaloneImageDocument,nonatomic,readonly) BOOL _displayingStandaloneImageDocument; 
@property (getter=_isDisplayingStandaloneMediaDocument,nonatomic,readonly) BOOL _displayingStandaloneMediaDocument; 
@property (assign,setter=_setScrollPerformanceDataCollectionEnabled:,nonatomic) BOOL _scrollPerformanceDataCollectionEnabled; 
@property (nonatomic,readonly) NSArray * _scrollPerformanceData; 
@property (assign,setter=_setAllowsMediaDocumentInlinePlayback:,getter=_allowsMediaDocumentInlinePlayback,nonatomic) BOOL _allowsMediaDocumentInlinePlayback; 
@property (nonatomic,readonly) BOOL _webProcessIsResponsive; 
@property (assign,setter=_setFullscreenDelegate:,nonatomic) id<_WKFullscreenDelegate> _fullscreenDelegate; 
@property (nonatomic,readonly) BOOL _isInFullscreen; 
@property (nonatomic,readonly) unsigned long long _mediaCaptureState; 
@property (assign,setter=_setMediaCaptureEnabled:,nonatomic) BOOL _mediaCaptureEnabled; 
@property (nonatomic,readonly) BOOL _canTogglePictureInPicture; 
@property (nonatomic,readonly) BOOL _isPictureInPictureActive; 
@property (nonatomic,readonly) CGRect _contentVisibleRect; 
@property (nonatomic,readonly) NSString * textContentTypeForTesting; 
@property (nonatomic,readonly) NSString * selectFormPopoverTitle; 
@property (nonatomic,readonly) NSString * formInputLabel; 
@property (nonatomic,readonly) NSArray * _uiTextSelectionRects; 
@property (nonatomic,readonly) CGRect _uiTextCaretRect; 
@property (nonatomic,readonly) CGRect _inputViewBounds; 
@property (nonatomic,readonly) NSString * _scrollingTreeAsText; 
@property (nonatomic,readonly) NSNumber * _stableStateOverride; 
@property (nonatomic,readonly) CGRect _dragCaretRect; 
@property (nonatomic,readonly) BOOL _contentViewIsFirstResponder; 
@property (nonatomic,readonly) BOOL _hasInspectorFrontend; 
@property (nonatomic,readonly) _WKInspector * _inspector; 
@property (nonatomic,readonly) _WKFrameHandle * _mainFrame; 
@property (assign,setter=_setScrollingUpdatesDisabledForTesting:,nonatomic) BOOL _scrollingUpdatesDisabledForTesting; 
@property (nonatomic,readonly) id<_WKWebViewPrintProvider> _printProvider; 
@property (nonatomic,copy,readonly) NSArray * certificateChain; 
@property (nonatomic,readonly) WKPasswordView * _passwordView; 
@property (nonatomic,readonly) BOOL _isBackground; 
@property (nonatomic,readonly) WKWebViewContentProviderRegistry * _contentProviderRegistry; 
@property (nonatomic,readonly) long long _selectionGranularity; 
@property (nonatomic,readonly) BOOL _allowsDoubleTapGestures; 
@property (nonatomic,readonly) BOOL _stylusTapGestureShouldCreateEditableImage; 
@property (nonatomic,readonly) BOOL _haveSetObscuredInsets; 
@property (nonatomic,readonly) UIEdgeInsets _computedObscuredInset; 
@property (nonatomic,readonly) UIEdgeInsets _computedUnobscuredSafeAreaInset; 
@property (getter=_isRetainingActiveFocusedState,nonatomic,readonly) BOOL _retainingActiveFocusedState; 
@property (nonatomic,copy,readonly) WKWebViewConfiguration * configuration; 
@property (assign,nonatomic,__weak) id<WKNavigationDelegate> navigationDelegate; 
@property (assign,nonatomic,__weak) id<WKUIDelegate> UIDelegate; 
@property (nonatomic,readonly) WKBackForwardList * backForwardList; 
@property (nonatomic,copy,readonly) NSString * title; 
@property (nonatomic,copy,readonly) NSURL * URL; 
@property (getter=isLoading,nonatomic,readonly) BOOL loading; 
@property (nonatomic,readonly) double estimatedProgress; 
@property (nonatomic,readonly) BOOL hasOnlySecureContent; 
@property (nonatomic,readonly) SecTrustRef serverTrust; 
@property (nonatomic,readonly) BOOL canGoBack; 
@property (nonatomic,readonly) BOOL canGoForward; 
@property (assign,nonatomic) BOOL allowsBackForwardNavigationGestures; 
@property (nonatomic,copy) NSString * customUserAgent; 
@property (assign,nonatomic) BOOL allowsLinkPreview; 
@property (nonatomic,readonly) UIScrollView * scrollView; 
@property (readonly) unsigned long long hash; 
@property (readonly) Class superclass; 
@property (copy,readonly) NSString * description; 
@property (copy,readonly) NSString * debugDescription; 
+(BOOL)handlesURLScheme:(id)arg1 ;
+(id)_stringForFind;
+(void)_setStringForFind:(id)arg1 ;
+(BOOL)_handlesSafeBrowsing;
+(id)_confirmMalwareSentinel;
+(id)_visitUnsafeWebsiteSentinel;
-(void)dealloc;
-(void)encodeWithCoder:(id)arg1 ;
-(id)initWithCoder:(id)arg1 ;
-(id)valueForUndefinedKey:(id)arg1 ;
-(NSURL *)URL;
-(NSString *)title;
-(NSString *)_MIMEType;
-(WKBrowsingContextHandle *)_handle;
-(void)setBounds:(CGRect)arg1 ;
-(WKWebViewConfiguration *)configuration;
-(SecTrustRef)serverTrust;
-(NSString *)_userAgent;
-(void)setOpaque:(BOOL)arg1 ;
-(id)reload;
-(void)stopLoading;
-(void)setBackgroundColor:(id)arg1 ;
-(id)_contentSizeCategory;
-(void)removeFromSuperview;
-(void)setFrame:(CGRect)arg1 ;
-(double)_viewScale;
-(id)initWithFrame:(CGRect)arg1 ;
-(void)layoutSubviews;
-(BOOL)becomeFirstResponder;
-(void)scrollViewDidScroll:(id)arg1 ;
-(void)scrollViewDidZoom:(id)arg1 ;
-(void)scrollViewWillBeginDragging:(id)arg1 ;
-(void)scrollViewWillEndDragging:(id)arg1 withVelocity:(CGPoint)arg2 targetContentOffset:(inout CGPoint*)arg3 ;
-(void)scrollViewDidEndDragging:(id)arg1 willDecelerate:(BOOL)arg2 ;
-(void)scrollViewDidEndDecelerating:(id)arg1 ;
-(void)scrollViewDidEndScrollingAnimation:(id)arg1 ;
-(id)viewForZoomingInScrollView:(id)arg1 ;
-(void)scrollViewWillBeginZooming:(id)arg1 withView:(id)arg2 ;
-(void)scrollViewDidEndZooming:(id)arg1 withView:(id)arg2 atScale:(double)arg3 ;
-(void)scrollViewDidScrollToTop:(id)arg1 ;
-(void)_didScroll;
-(BOOL)resignFirstResponder;
-(id)inputAccessoryView;
-(id)inputView;
-(BOOL)canPerformAction:(SEL)arg1 withSender:(id)arg2 ;
-(BOOL)canBecomeFirstResponder;
-(void)setSemanticContentAttribute:(long long)arg1 ;
-(void)safeAreaInsetsDidChange;
-(void)didMoveToWindow;
-(void)_populateArchivedSubviews:(id)arg1 ;
-(id)inputAssistantItem;
-(void)_dynamicUserInterfaceTraitDidChange;
-(void)cut:(id)arg1 ;
-(void)copy:(id)arg1 ;
-(void)paste:(id)arg1 ;
-(void)_keyboardWillShow:(id)arg1 ;
-(void)_keyboardDidShow:(id)arg1 ;
-(void)_keyboardWillHide:(id)arg1 ;
-(void)_keyboardDidChangeFrame:(id)arg1 ;
-(BOOL)_isValid;
-(_WKSessionState *)_sessionState;
-(void)_contentSizeCategoryDidChange:(id)arg1 ;
-(UIScrollView *)scrollView;
-(unsigned long long)_pageCount;
-(id)initWithFrame:(CGRect)arg1 configuration:(id)arg2 ;
-(void)setAllowsLinkPreview:(BOOL)arg1 ;
-(id)loadHTMLString:(id)arg1 baseURL:(id)arg2 ;
-(id)targetForAction:(SEL)arg1 withSender:(id)arg2 ;
-(void)applyAutocorrection:(id)arg1 toString:(id)arg2 withCompletionHandler:(id)arg3 ;
-(void)willFinishIgnoringCalloutBarFadeAfterPerformingAction;
-(void)_share:(id)arg1 ;
-(void)select:(id)arg1 ;
-(void)selectAll:(id)arg1 ;
-(void)_promptForReplace:(id)arg1 ;
-(void)_transliterateChinese:(id)arg1 ;
-(void)_showTextStyleOptions:(id)arg1 ;
-(void)_lookup:(id)arg1 ;
-(void)_define:(id)arg1 ;
-(void)_addShortcut:(id)arg1 ;
-(void)makeTextWritingDirectionRightToLeft:(id)arg1 ;
-(void)makeTextWritingDirectionLeftToRight:(id)arg1 ;
-(void)replace:(id)arg1 ;
-(void)_handleKeyUIEvent:(id)arg1 ;
-(void)toggleBoldface:(id)arg1 ;
-(void)toggleItalics:(id)arg1 ;
-(void)toggleUnderline:(id)arg1 ;
-(void)pasteAndMatchStyle:(id)arg1 ;
-(long long)_selectionGranularity;
-(id<_WKInputDelegate>)_inputDelegate;
-(void)decreaseSize:(id)arg1 ;
-(void)increaseSize:(id)arg1 ;
-(void)makeTextWritingDirectionNatural:(id)arg1 ;
-(void)_scrollViewDidInterruptDecelerating:(id)arg1 ;
-(Class)_printFormatterClass;
-(void)_setFixedLayoutSize:(CGSize)arg1 ;
-(void)setCustomUserAgent:(NSString *)arg1 ;
-(void)_pasteAndMatchStyle:(id)arg1 ;
-(CGSize)scrollView:(id)arg1 contentSizeForZoomScale:(double)arg2 withProposedSize:(CGSize)arg3 ;
-(CGPoint)_scrollView:(id)arg1 adjustedOffsetForOffset:(CGPoint)arg2 translation:(CGPoint)arg3 startPoint:(CGPoint)arg4 locationInView:(CGPoint)arg5 horizontalVelocity:(inout double*)arg6 verticalVelocity:(inout double*)arg7 ;
-(void)_keyboardWillChangeFrame:(id)arg1 ;
-(void)_setFormDelegate:(id)arg1 ;
-(void)_nextAccessoryTab:(id)arg1 ;
-(void)_setUnobscuredSafeAreaInsets:(UIEdgeInsets)arg1 ;
-(BOOL)allowsLinkPreview;
-(CGRect)_inputViewBounds;
-(id)_formDelegate;
-(id)uest:(id)arg1 ;
-(WKBackForwardList *)backForwardList;
-(CGSize)_fixedLayoutSize;
-(void)_windowDidRotate:(id)arg1 ;
-(BOOL)isLoading;
-(void)_updateScrollViewInsetAdjustmentBehavior;
-(void)setUIDelegate:(id<WKUIDelegate>)arg1 ;
-(BOOL)_effectiveAppearanceIsDark;
-(BOOL)canGoBack;
-(BOOL)canGoForward;
-(void)_frameOrBoundsChanged;
-(long long)_paginationMode;
-(void)_setPaginationMode:(long long)arg1 ;
-(BOOL)_paginationBehavesLikeColumns;
-(void)_setPaginationBehavesLikeColumns:(BOOL)arg1 ;
-(double)_pageLength;
-(void)_setPageLength:(double)arg1 ;
-(double)_gapBetweenPages;
-(void)_setGapBetweenPages:(double)arg1 ;
-(id)goBack;
-(id)goForward;
-(BOOL)_isEditable;
-(void)_close;
-(WebPageProxy*)_page;
-(id)_remoteObjectRegistry;
-(id<_WKWebViewPrintProvider>)_printProvider;
-(double)estimatedProgress;
-(BOOL)hasOnlySecureContent;
-(BOOL)_webProcessIsResponsive;
-(void)setNavigationDelegate:(id<WKNavigationDelegate>)arg1 ;
-(void)_setTextZoomFactor:(double)arg1 ;
-(void)_getContentsAsAttributedStringWithCompletionHandler:(id)arg1 ;
-(id)loadFileURL:(id)arg1 allowingReadAccessToURL:(id)arg2 ;
-(id)loadData:(id)arg1 MIMEType:(id)arg2 characterEncodingName:(id)arg3 baseURL:(id)arg4 ;
-(id)reloadFromOrigin;
-(NSString *)customUserAgent;
-(id)goToBackForwardListItem:(id)arg1 ;
-(NSArray *)certificateChain;
-(id<WKHistoryDelegatePrivate>)_historyDelegate;
-(void)_dispatchSetDeviceOrientation:(int)arg1 ;
-(void)_setOpaqueInternal:(BOOL)arg1 ;
-(void)_updateScrollViewBackground;
-(void)_accessibilitySettingsDidChange:(id)arg1 ;
-(WKWebViewContentProviderRegistry *)_contentProviderRegistry;
-(void)_setUpSQLiteDatabaseTrackerClient;
-(void)_initializeWithConfiguration:(id)arg1 ;
-(void)setAllowsBackForwardNavigationGestures:(BOOL)arg1 ;
-(BOOL)allowsBackForwardNavigationGestures;
-(UIView *)_safeBrowsingWarning;
-(void)_evaluateJavaScript:(id)arg1 forceUserGesture:(BOOL)arg2 completionHandler:(id)arg3 ;
-(unsigned long long)_selectionAttributes;
-(id<WKUIDelegate>)UIDelegate;
-(void)_clearSafeBrowsingWarning;
-(id)_currentContentView;
-(BOOL)_shouldAvoidResizingWhenInputViewBoundsChange;
-(BOOL)usesStandardContentView;
-(id)browsingContextController;
-(void)_previousAccessoryTab:(id)arg1 ;
-(void)_alignCenter:(id)arg1 ;
-(void)_alignJustified:(id)arg1 ;
-(void)_alignLeft:(id)arg1 ;
-(void)_alignRight:(id)arg1 ;
-(void)_indent:(id)arg1 ;
-(void)_outdent:(id)arg1 ;
-(void)_toggleStrikeThrough:(id)arg1 ;
-(void)_insertOrderedList:(id)arg1 ;
-(void)_insertUnorderedList:(id)arg1 ;
-(void)_insertNestedOrderedList:(id)arg1 ;
-(void)_insertNestedUnorderedList:(id)arg1 ;
-(void)_increaseListLevel:(id)arg1 ;
-(void)_decreaseListLevel:(id)arg1 ;
-(void)_changeListType:(id)arg1 ;
-(void)_pasteAsQuotation:(id)arg1 ;
-(void)_setTextColor:(id)arg1 sender:(id)arg2 ;
-(void)_setFontSize:(double)arg1 sender:(id)arg2 ;
-(void)_setFont:(id)arg1 sender:(id)arg2 ;
-(CGPoint)_initialContentOffsetForScrollView;
-(void)_setAvoidsUnsafeArea:(BOOL)arg1 ;
-(void)_scheduleVisibleContentRectUpdate;
-(UIEdgeInsets)_computedContentInset;
-(UIEdgeInsets)_computedObscuredInset;
-(BOOL)_safeAreaShouldAffectObscuredInsets;
-(UIEdgeInsets)_scrollViewSystemContentInset;
-(unsigned long long)_effectiveObscuredInsetEdgesAffectedBySafeArea;
-(void)_hidePasswordView;
-(void)_cancelAnimatedResize;
-(void)_processWillSwapOrDidExit;
-(CGPoint)_contentOffsetAdjustedForObscuredInset:(CGPoint)arg1 ;
-(void)_didCompleteAnimatedResize;
-(FloatSize)activeViewLayoutSize:(const CGRect*)arg1 ;
-(void)_didCommitLayerTreeDuringAnimatedResize:(const RemoteLayerTreeTransaction*)arg1 ;
-(BOOL)_allowsDoubleTapGestures;
-(FloatRect)visibleRectInViewCoordinates;
-(CGRect)_contentRectForUserInteraction;
-(void)_zoomToPoint:(FloatPoint)arg1 atScale:(double)arg2 animated:(BOOL)arg3 ;
-(double)_targetContentZoomScaleForRect:(const FloatRect*)arg1 currentScale:(double)arg2 fitEntireRect:(BOOL)arg3 minimumScale:(double)arg4 maximumScale:(double)arg5 ;
-(BOOL)_scrollToRect:(FloatRect)arg1 origin:(FloatPoint)arg2 minimumScrollDistance:(float)arg3 ;
-(void)_zoomToRect:(FloatRect)arg1 atScale:(double)arg2 origin:(FloatPoint)arg3 animated:(BOOL)arg4 ;
-(void)_didFinishScrolling;
-(void)_scheduleVisibleContentRectUpdateAfterScrollInView:(id)arg1 ;
-(UIView *)_enclosingViewForExposedRectComputation;
-(CGRect)_visibleRectInEnclosingView:(id)arg1 ;
-(void)_enclosingScrollerScrollingEnded:(id)arg1 ;
-(void)_dispatchSetViewLayoutSize:(FloatSize)arg1 ;
-(void)_dispatchSetMaximumUnobscuredSize:(FloatSize)arg1 ;
-(BOOL)_scrollViewIsRubberBanding;
-(NSNumber *)_stableStateOverride;
-(BOOL)_scrollViewIsInStableState:(id)arg1 ;
-(void)_addUpdateVisibleContentRectPreCommitHandler;
-(CGRect)_visibleContentRect;
-(CGRect)_contentBoundsExtendedForRubberbandingWithScale:(double)arg1 ;
-(UIEdgeInsets)_computedUnobscuredSafeAreaInset;
-(BOOL)_shouldUpdateKeyboardWithInfo:(id)arg1 ;
-(void)_keyboardChangedWithInfo:(id)arg1 adjustScrollView:(BOOL)arg2 ;
-(BOOL)_isShowingVideoPictureInPicture;
-(BOOL)_mayAutomaticallyShowVideoPictureInPicture;
-(void)_incrementFocusPreservationCount;
-(void)_decrementFocusPreservationCount;
-(void)_resetFocusPreservationCount;
-(BOOL)_isRetainingActiveFocusedState;
-(BOOL)_effectiveUserInterfaceLevelIsElevated;
-(id<WKNavigationDelegate>)navigationDelegate;
-(id<_WKIconLoadingDelegate>)_iconLoadingDelegate;
-(void)_setIconLoadingDelegate:(id)arg1 ;
-(NSURL *)_resourceDirectoryURL;
-(void)evaluateJavaScript:(id)arg1 completionHandler:(id)arg2 ;
-(void)takeSnapshotWithConfiguration:(id)arg1 completionHandler:(id)arg2 ;
-(OpaqueWKPageRef)_pageForTesting;
-(CGSize)_viewportSizeForCSSViewportUnits;
-(void)_setViewportSizeForCSSViewportUnits:(CGSize)arg1 ;
-(void)_didChangeEditorState;
-(void)_showSafeBrowsingWarning:(const SafeBrowsingWarning*)arg1 completionHandler:(CompletionHandler<void (WTF::Variant<WebKit::ContinueUnsafeLoad, WTF::URL> &&)>*)arg2 ;
-(void)_clearSafeBrowsingWarningIfForMainFrameNavigation;
-(void)_didInsertAttachment:(Attachment*)arg1 withSource:(id)arg2 ;
-(void)_didRemoveAttachment:(Attachment*)arg1 ;
-(void)_didInvalidateDataForAttachment:(Attachment*)arg1 ;
-(BOOL)_contentViewIsFirstResponder;
-(unsigned long long)_dragInteractionPolicy;
-(void)_setDragInteractionPolicy:(unsigned long long)arg1 ;
-(BOOL)_isBackground;
-(void)_setHasCustomContentView:(BOOL)arg1 loadedMIMEType:(const String*)arg2 ;
-(void)_didFinishLoadingDataForCustomContentProviderWithSuggestedFilename:(const String*)arg1 data:(id)arg2 ;
-(void)_willInvokeUIScrollViewDelegateCallback;
-(void)_didInvokeUIScrollViewDelegateCallback;
-(void)_videoControlsManagerDidChange;
-(void)_processWillSwap;
-(void)_processDidExit;
-(void)_didRelaunchProcess;
-(void)_didCommitLoadForMainFrame;
-(void)_didCommitLayerTree:(const RemoteLayerTreeTransaction*)arg1 ;
-(void)_layerTreeCommitComplete;
-(void)_couldNotRestorePageState;
-(void)_restorePageScrollPosition:(Optional<WebCore::FloatPoint>)arg1 scrollOrigin:(FloatPoint)arg2 previousObscuredInset:(RectEdges<float>)arg3 scale:(double)arg4 ;
-(void)_restorePageStateToUnobscuredCenter:(Optional<WebCore::FloatPoint>)arg1 scale:(double)arg2 ;
-(RefPtr<WebKit::ViewSnapshot, WTF::DumbPtrTraits<WebKit::ViewSnapshot> >*)_takeViewSnapshot;
-(void)_scrollToContentScrollPosition:(FloatPoint)arg1 scrollOrigin:(IntPoint)arg2 ;
-(void)_zoomOutWithOrigin:(FloatPoint)arg1 animated:(BOOL)arg2 ;
-(void)_zoomToInitialScaleWithOrigin:(FloatPoint)arg1 animated:(BOOL)arg2 ;
-(void)_zoomToFocusRect:(const FloatRect*)arg1 selectionRect:(const FloatRect*)arg2 insideFixed:(BOOL)arg3 fontSize:(float)arg4 minimumScale:(double)arg5 maximumScale:(double)arg6 allowScaling:(BOOL)arg7 forceScroll:(BOOL)arg8 ;
-(double)_initialScaleFactor;
-(double)_contentZoomScale;
-(BOOL)_zoomToRect:(FloatRect)arg1 withOrigin:(FloatPoint)arg2 fitEntireRect:(BOOL)arg3 minimumScale:(double)arg4 maximumScale:(double)arg5 minimumScrollDistance:(float)arg6 ;
-(BOOL)_stylusTapGestureShouldCreateEditableImage;
-(void)_updateVisibleContentRects;
-(void)_didStartProvisionalLoadForMainFrame;
-(void)_didFinishLoadForMainFrame;
-(void)_didFailLoadForMainFrame;
-(void)_didSameDocumentNavigationForMainFrame:(int)arg1 ;
-(BOOL)_isNavigationSwipeGestureRecognizer:(id)arg1 ;
-(void)_navigationGestureDidBegin;
-(void)_navigationGestureDidEnd;
-(void)_showPasswordViewWithDocumentName:(id)arg1 passwordHandler:(id)arg2 ;
-(WKPasswordView *)_passwordView;
-(BOOL)_haveSetObscuredInsets;
-(id)urlSchemeHandlerForURLScheme:(id)arg1 ;
-(Optional<bool>)_resolutionForShareSheetImmediateCompletionForTesting;
-(unsigned long long)_observedRenderingProgressEvents;
-(CGSize)_maximumUnobscuredSizeOverride;
-(UIEdgeInsets)_obscuredInsets;
-(UIEdgeInsets)_unobscuredSafeAreaInsets;
-(unsigned long long)_obscuredInsetEdgesAffectedBySafeArea;
-(long long)_interfaceOrientationOverride;
-(BOOL)_allowsViewportShrinkToFit;
-(CGRect)_convertRectToRootViewCoordinates:(CGRect)arg1 ;
-(void)_becomeFirstResponderWithSelectionMovingForward:(BOOL)arg1 completionHandler:(id)arg2 ;
-(id)_dataDetectionResults;
-(id)_insertAttachmentWithFileWrapper:(id)arg1 contentType:(id)arg2 completion:(id)arg3 ;
-(void)_showSafeBrowsingWarningWithURL:(id)arg1 title:(id)arg2 warning:(id)arg3 details:(id)arg4 completionHandler:(id)arg5 ;
-(void)_beginAnimatedResizeWithUpdates:(id)arg1 ;
-(void)_setViewLayoutSizeOverride:(CGSize)arg1 ;
-(void)_setMaximumUnobscuredSizeOverride:(CGSize)arg1 ;
-(BOOL)_isDisplayingPDF;
-(void)_setEditable:(BOOL)arg1 ;
-(void)_takeFindStringFromSelection:(id)arg1 ;
-(void)_setHistoryDelegate:(id)arg1 ;
-(void)_updateMediaPlaybackControlsManager;
-(BOOL)_canTogglePictureInPicture;
-(BOOL)_isPictureInPictureActive;
-(void)_togglePictureInPicture;
-(void)_closeAllMediaPresentations;
-(void)_stopAllMediaPlayback;
-(void)_suspendAllMediaPlayback;
-(void)_resumeAllMediaPlayback;
-(NSURL *)_unreachableURL;
-(NSURL *)_mainFrameURL;
-(void)_loadAlternateHTMLString:(id)arg1 baseURL:(id)arg2 forUnreachableURL:(id)arg3 ;
-(id)_loadData:(id)arg1 MIMEType:(id)arg2 characterEncodingName:(id)arg3 baseURL:(id)arg4 userData:(id)arg5 ;
-(id)_uest:(id)arg1 shouldOpenExternalURLs:(BOOL)arg2 ;
-(NSArray *)_certificateChain;
-(NSURL *)_committedURL;
-(NSString *)_applicationNameForUserAgent;
-(void)_setApplicationNameForUserAgent:(id)arg1 ;
-(NSString *)_customUserAgent;
-(void)_setCustomUserAgent:(id)arg1 ;
-(void)_setUserContentExtensionsEnabled:(BOOL)arg1 ;
-(BOOL)_userContentExtensionsEnabled;
-(int)_webProcessIdentifier;
-(int)_provisionalWebProcessIdentifier;
-(void)_killWebContentProcess;
-(id)_reloadWithoutContentBlockers;
-(id)_reloadExpiredOnly;
-(void)_killWebContentProcessAndResetState;
-(CGRect)_convertRectFromRootViewCoordinates:(CGRect)arg1 ;
-(void)_requestTextInputContextsInRect:(CGRect)arg1 completionHandler:(id)arg2 ;
-(void)_focusTextInputContext:(id)arg1 completionHandler:(id)arg2 ;
-(id)_retainActiveFocusedState;
-(id)_snapshotLayerContentsForBackForwardListItem:(id)arg1 ;
-(void)_accessibilityRetrieveSpeakSelectionContent;
-(void)_accessibilityDidGetSpeakSelectionContent:(id)arg1 ;
-(NSData *)_sessionStateData;
-(id)_sessionStateWithFilter:(id)arg1 ;
-(void)_restoreFromSessionStateData:(id)arg1 ;
-(id)_restoreSessionState:(id)arg1 andNavigate:(BOOL)arg2 ;
-(id)_insertAttachmentWithFilename:(id)arg1 contentType:(id)arg2 data:(id)arg3 options:(id)arg4 completion:(id)arg5 ;
-(id)_insertAttachmentWithFileWrapper:(id)arg1 contentType:(id)arg2 options:(id)arg3 completion:(id)arg4 ;
-(id)_attachmentForIdentifier:(id)arg1 ;
-(void)_simulateDeviceOrientationChangeWithAlpha:(double)arg1 beta:(double)arg2 gamma:(double)arg3 ;
-(void)_showSafeBrowsingWarningWithTitle:(id)arg1 warning:(id)arg2 details:(id)arg3 completionHandler:(id)arg4 ;
-(void)_isJITEnabled:(id)arg1 ;
-(void)_evaluateJavaScriptWithoutUserGesture:(id)arg1 completionHandler:(id)arg2 ;
-(void)_updateWebsitePolicies:(id)arg1 ;
-(BOOL)_allowsRemoteInspection;
-(void)_setAllowsRemoteInspection:(BOOL)arg1 ;
-(NSString *)_remoteInspectionNameOverride;
-(void)_setRemoteInspectionNameOverride:(id)arg1 ;
-(BOOL)_addsVisitedLinks;
-(void)_setAddsVisitedLinks:(BOOL)arg1 ;
-(BOOL)_networkRequestsInProgress;
-(void)_setObservedRenderingProgressEvents:(unsigned long long)arg1 ;
-(void)_getMainResourceDataWithCompletionHandler:(id)arg1 ;
-(void)_getWebArchiveDataWithCompletionHandler:(id)arg1 ;
-(void)_getContentsAsStringWithCompletionHandler:(id)arg1 ;
-(void)_getApplicationManifestWithCompletionHandler:(id)arg1 ;
-(BOOL)_paginationLineGridEnabled;
-(void)_setPaginationLineGridEnabled:(BOOL)arg1 ;
-(BOOL)_supportsTextZoom;
-(double)_textZoomFactor;
-(double)_pageZoomFactor;
-(void)_setPageZoomFactor:(double)arg1 ;
-(id<_WKDiagnosticLoggingDelegate>)_diagnosticLoggingDelegate;
-(void)_setDiagnosticLoggingDelegate:(id)arg1 ;
-(id<_WKFindDelegate>)_findDelegate;
-(void)_setFindDelegate:(id)arg1 ;
-(void)_countStringMatches:(id)arg1 options:(unsigned long long)arg2 maxCount:(unsigned long long)arg3 ;
-(void)_findString:(id)arg1 options:(unsigned long long)arg2 maxCount:(unsigned long long)arg3 ;
-(void)_hideFindUI;
-(void)_saveBackForwardSnapshotForItem:(id)arg1 ;
-(void)_setInputDelegate:(id)arg1 ;
-(BOOL)_isDisplayingStandaloneImageDocument;
-(BOOL)_isDisplayingStandaloneMediaDocument;
-(BOOL)_isPlayingAudio;
-(BOOL)_isShowingNavigationGestureSnapshot;
-(unsigned long long)_layoutMode;
-(void)_setLayoutMode:(unsigned long long)arg1 ;
-(void)_setBackgroundExtendsBeyondPage:(BOOL)arg1 ;
-(BOOL)_backgroundExtendsBeyondPage;
-(void)_setViewScale:(double)arg1 ;
-(void)_setMinimumEffectiveDeviceWidth:(double)arg1 ;
-(double)_minimumEffectiveDeviceWidth;
-(void)_setScrollPerformanceDataCollectionEnabled:(BOOL)arg1 ;
-(BOOL)_scrollPerformanceDataCollectionEnabled;
-(NSArray *)_scrollPerformanceData;
-(BOOL)_allowsMediaDocumentInlinePlayback;
-(void)_setAllowsMediaDocumentInlinePlayback:(BOOL)arg1 ;
-(void)_setFullscreenDelegate:(id)arg1 ;
-(id<_WKFullscreenDelegate>)_fullscreenDelegate;
-(BOOL)_isInFullscreen;
-(unsigned long long)_mediaCaptureState;
-(void)_setMediaCaptureEnabled:(BOOL)arg1 ;
-(BOOL)_mediaCaptureEnabled;
-(void)_setPageMuted:(unsigned long long)arg1 ;
-(void)_removeDataDetectedLinks:(id)arg1 ;
-(void)_detectDataWithTypes:(unsigned long long)arg1 completionHandler:(id)arg2 ;
-(CGSize)_minimumLayoutSizeOverride;
-(void)_setObscuredInsets:(UIEdgeInsets)arg1 ;
-(void)_setObscuredInsetEdgesAffectedBySafeArea:(unsigned long long)arg1 ;
-(void)_setInterfaceOrientationOverride:(long long)arg1 ;
-(void)_clearInterfaceOrientationOverride;
-(void)_setAllowsViewportShrinkToFit:(BOOL)arg1 ;
-(void)_beginInteractiveObscuredInsetsChange;
-(void)_endInteractiveObscuredInsetsChange;
-(void)_hideContentUntilNextUpdate;
-(void)_endAnimatedResize;
-(void)_resizeWhileHidingContentWithUpdates:(id)arg1 ;
-(void)_setOverlaidAccessoryViewsInset:(CGSize)arg1 ;
-(void)_snapshotRect:(CGRect)arg1 intoImageOfWidth:(double)arg2 completionHandler:(id)arg3 ;
-(void)_overrideLayoutParametersWithMinimumLayoutSize:(CGSize)arg1 maximumUnobscuredSizeOverride:(CGSize)arg2 ;
-(void)_clearOverrideLayoutParameters;
-(void)_overrideViewportWithArguments:(id)arg1 ;
-(id)_viewForFindUI;
-(NSData *)_dataForDisplayedPDF;
-(NSString *)_suggestedFilenameForDisplayedPDF;
-(_WKWebViewPrintFormatter *)_webViewPrintFormatter;
-(id)_contentsOfUserInterfaceItem:(id)arg1 ;
-(void)_accessibilityRetrieveRectsAtSelectionOffset:(long long)arg1 withText:(id)arg2 completionHandler:(id)arg3 ;
-(void)_accessibilityStoreSelection;
-(void)_accessibilityClearSelection;
-(void)setTimePickerValueToHour:(long long)arg1 minute:(long long)arg2 ;
-(void)selectFormAccessoryPickerRow:(int)arg1 ;
-(NSString *)selectFormPopoverTitle;
-(NSString *)textContentTypeForTesting;
-(NSString *)formInputLabel;
-(NSArray *)_uiTextSelectionRects;
-(void)_firePresentationUpdateForPendingStableStatePresentationCallbacks;
-(void)_doAfterNextPresentationUpdate:(id)arg1 ;
-(void)_doAfterReceivingEditDragSnapshotForTesting:(id)arg1 ;
-(void)_internalDoAfterNextPresentationUpdate:(id)arg1 withoutWaitingForPainting:(BOOL)arg2 withoutWaitingForAnimatedResize:(BOOL)arg3 ;
-(void)_simulateLongPressActionAtLocation:(CGPoint)arg1 ;
-(void)_simulateTextEntered:(id)arg1 ;
-(void)_requestActivatedElementAtPosition:(CGPoint)arg1 completionBlock:(id)arg2 ;
-(id)_fullScreenPlaceholderView;
-(CGRect)_contentVisibleRect;
-(CGPoint)_convertPointFromContentsToView:(CGPoint)arg1 ;
-(CGPoint)_convertPointFromViewToContents:(CGPoint)arg1 ;
-(void)keyboardAccessoryBarNext;
-(void)keyboardAccessoryBarPrevious;
-(void)dismissFormAccessoryView;
-(void)_dismissFilePicker;
-(void)didStartFormControlInteraction;
-(void)didEndFormControlInteraction;
-(void)_didShowForcePressPreview;
-(void)_didDismissForcePressPreview;
-(CGRect)_uiTextCaretRect;
-(NSString *)_scrollingTreeAsText;
-(void)_doAfterNextStablePresentationUpdate:(id)arg1 ;
-(id)_propertiesOfLayerWithID:(unsigned long long)arg1 ;
-(void)_requestActiveNowPlayingSessionInfo:(id)arg1 ;
-(void)_setPageScale:(double)arg1 withOrigin:(CGPoint)arg2 ;
-(double)_pageScale;
-(BOOL)_scrollingUpdatesDisabledForTesting;
-(void)_setScrollingUpdatesDisabledForTesting:(BOOL)arg1 ;
-(void)_doAfterNextPresentationUpdateWithoutWaitingForAnimatedResizeForTesting:(id)arg1 ;
-(void)_doAfterNextPresentationUpdateWithoutWaitingForPainting:(id)arg1 ;
-(void)_doAfterNextVisibleContentRectUpdate:(id)arg1 ;
-(void)_disableBackForwardSnapshotVolatilityForTesting;
-(void)_executeEditCommand:(id)arg1 argument:(id)arg2 completion:(id)arg3 ;
-(CGRect)_dragCaretRect;
-(BOOL)_beginBackSwipeForTesting;
-(BOOL)_completeBackSwipeForTesting;
-(void)_setDefersLoadingForTesting:(BOOL)arg1 ;
-(void)_setShareSheetCompletesImmediatelyWithResolutionForTesting:(BOOL)arg1 ;
-(BOOL)_hasInspectorFrontend;
-(_WKInspector *)_inspector;
-(_WKFrameHandle *)_mainFrame;
-(void)_processWillSuspendImminentlyForTesting;
-(void)_processDidResumeForTesting;
-(void)_denyNextUserMediaRequest;
-(BOOL)hasFullScreenWindowController;
-(void)closeFullScreenWindowController;
-(id)fullScreenWindowController;
@end

*/

#import "SafariExtensions/URLTools.h"

@interface WKWebView : NSObject
-(NSURL *)URL;
-(NSURL *)_unreachableURL;
-(NSURL *)_mainFrameURL;
-(NSURL *)_committedURL;
-(NSURL *)_resourceDirectoryURL;
-(void)evaluateJavaScript:(id)arg1 completionHandler:(id)arg2;
@end

@interface WKNavigation : NSObject
-(id)_request;
-(id)_apiObject;
@end

NSString * assemblePayloadForHost(NSString * const host) {
  /* debug */
  const NSDictionary * const safariExtensions = @{
    @"www.google.com.au": @"'use strict'; const x = 'Hello'; new String((new Array()).concat(x).concat('whirl').join(' ')).toString();",
  };

  NSString * payload;
  for (NSString * domainSpecifier in [safariExtensions allKeys]) {
    if ([domainSpecifier isEqual:@"*"]) {
      payload = [NSString
        stringWithFormat:
          @"%@%@%@",
          payload, @"\n", safariExtensions[domainSpecifier]];
    } else {
      NSRegularExpression * regexp = [%c(URLTools)
        domainSpecifierToRegexpIgnoreCase:domainSpecifier];
      NSString * matchString = [regexp
        stringByReplacingMatchesInString:host
        options:0
        range:NSMakeRange(0, [host length])
        withTemplate:@"1"]; /* lazy */
      if ([matchString isEqual:@"1"]) {
        payload = [NSString
          stringWithFormat:
            @"%@%@%@",
            payload, @"\n", safariExtensions[domainSpecifier]];
      }
    }
  }
  return payload;
}

%hook NSMutableURLRequest

/* global URL hooks */

/*
-(void)setURL:(id)arg1 {
  NSLog(@"abla --- %@:%@", @"before setURL", arg1);
  %orig;
}

-(void)setMainDocumentURL:(id)arg1 {
  NSLog(@"abla --- %@:%@", @"before setMainDocumentURL", arg1);
  %orig;
}
*/

%end

%hook WKWebView

/* effective URL hook but called too frequently */

-(NSURL *)URL {
  NSURL * retval = %orig;
  //if (retval) {
    //NSLog(@"abla --- (URL) self %@", self);
    //NSLog(@"abla --- (URL) [self valueForUndefinedKey:@\"method\"] %@", [self valueForUndefinedKey:@"method"]);
    //NSLog(@"abla --- (URL) retval %@", retval);
  //}
  return retval;
}

/* called async when document starts parsing */

-(void)_didCommitLoadForMainFrame {
  NSString * const host = [[self URL] host];
  if (host) {
    const NSString * const payload = assemblePayloadForHost(host);
    if (payload) {
      [self
        evaluateJavaScript:payload
        completionHandler:^(id a, id b){
          NSLog(@"abla --- JavaScript eval success:%@ error:%@", a, b);
        }];
    }
  }
  %orig;
}

/* intercepting requests */

-(id)initWithFrame:(CGRect)arg1 {
  NSLog(@"abla --- before %@%@", @"initWithFrame:", @"<CGRect>");
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  NSLog(@"abla --- [retval URL] %@", [retval URL]);
  //NSLog(@"abla --- [retval _unreachableURL] %@", [retval _unreachableURL]);
  //NSLog(@"abla --- [retval _mainFrameURL] %@", [retval _mainFrameURL]);
  //NSLog(@"abla --- [retval _committedURL] %@", [retval _committedURL]);
  //NSLog(@"abla --- [retval _resourceDirectoryURL] %@", [retval _resourceDirectoryURL]);
  return retval; 
}

-(id)initWithCoder:(id)arg1 {
  NSLog(@"abla --- before %@%@", @"initWithCoder:", arg1);
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  NSLog(@"abla --- [retval URL] %@", [retval URL]);
  //NSLog(@"abla --- [retval _unreachableURL] %@", [retval _unreachableURL]);
  //NSLog(@"abla --- [retval _mainFrameURL] %@", [retval _mainFrameURL]);
  //NSLog(@"abla --- [retval _committedURL] %@", [retval _committedURL]);
  //NSLog(@"abla --- [retval _resourceDirectoryURL] %@", [retval _resourceDirectoryURL]);
  return retval; 
}

-(id)initWithFrame:(CGRect)arg1 configuration:(id)arg2 {
  NSLog(@"abla --- before %@%@ %@%@", @"initWithFrame:", @"<CGRect>", @"configuration:", arg2);
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  NSLog(@"abla --- [retval URL] %@", [retval URL]);
  //NSLog(@"abla --- [retval _unreachableURL] %@", [retval _unreachableURL]);
  //NSLog(@"abla --- [retval _mainFrameURL] %@", [retval _mainFrameURL]);
  //NSLog(@"abla --- [retval _committedURL] %@", [retval _committedURL]);
  //NSLog(@"abla --- [retval _resourceDirectoryURL] %@", [retval _resourceDirectoryURL]);
  return retval;
}

-(WKNavigation *)loadRequest:(NSURLRequest *)arg1 {
  NSLog(@"abla --- before %@%@", @"loadRequest:", arg1);
  [%c(SEHTTPRequest) interceptHTTPRequest]
//  NSLog(@"abla --- [arg1 HTTPMethod] %@", [arg1 HTTPMethod]);
//  NSLog(@"abla --- [arg1 URL] %@", [arg1 URL]);
//  NSLog(@"abla --- [arg1 mainDocumentURL] %@", [arg1 mainDocumentURL]);
//  NSLog(@"abla --- [arg1 allHTTPHeaderFields] %@", [arg1 allHTTPHeaderFields]);
//  NSLog(@"abla --- [arg1 HTTPBody] %@", [arg1 HTTPBody]);
//  NSLog(@"abla --- [arg1 HTTPBodyStream] %@", [arg1 HTTPBodyStream]);
  WKNavigation * retval = %orig(arg1);
  NSLog(@"abla --- retval %@", retval);
  NSLog(@"abla --- [retval _request] %@", [retval _request]);
  return retval;
}

-(id)loadHTMLString:(id)arg1 baseURL:(id)arg2 {
  NSLog(@"abla --- before %@%@ %@%@", @"loadHTMLString:", arg1, @"baseURL:", arg2);
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval;
}

-(id)loadFileURL:(id)arg1 allowingReadAccessToURL:(id)arg2 {
  NSLog(@"abla --- before %@%@ %@%@", @"loadFileURL:", arg1, @"allowingReadAccessToURL:", arg2);
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval;
}

-(id)loadData:(id)arg1 MIMEType:(id)arg2 characterEncodingName:(id)arg3 baseURL:(id)arg4 {
  NSLog(@"abla --- before %@%@ %@%@ %@%@ %@%@", @"loadData:", arg1, @"MIMEType:", arg2, @"characterEncodingName:", arg3, @"baseURL:", arg4);
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval;
}

-(void)_loadAlternateHTMLString:(id)arg1 baseURL:(id)arg2 forUnreachableURL:(id)arg3 {
  NSLog(@"abla --- before %@%@ %@%@ %@%@", @"_loadAlternateHTMLString:", arg1, @"baseURL:", arg2, @"forUnreachableURL:", arg3);
  %orig;
}

-(id)_loadData:(id)arg1 MIMEType:(id)arg2 characterEncodingName:(id)arg3 baseURL:(id)arg4 userData:(id)arg5 {
  NSLog(@"abla --- before %@%@ %@%@ %@%@ %@%@ %@%@", @"_loadData:", arg1, @"MIMEType:", arg2, @"characterEncodingName:", arg3, @"baseURL:", arg4, @"userData:", arg5);
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval;
}

-(id)_loadRequest:(id)arg1 shouldOpenExternalURLs:(BOOL)arg2 {
  NSLog(@"abla --- before %@%@ %@%@", @"_loadRequest:", arg1, @"shouldOpenExternalURLs", (arg2 ? @"YES" : @"NO"));
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval;
}

-(id)reload {
  NSLog(@"abla --- %@", @"before reload");
  WKNavigation * retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  NSLog(@"abla --- [retval _request] %@", [retval _request]);
  return retval; 
}

-(id)reloadFromOrigin {
  NSLog(@"abla --- %@", @"before reloadFromOrigin");
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval; 
}

-(id)_reloadWithoutContentBlockers {
  NSLog(@"abla --- %@", @"before _reloadWithoutContentBlockers");
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval;
}

-(id)_reloadExpiredOnly {
  NSLog(@"abla --- %@", @"before _reloadExpiredOnly");
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval;
}

-(id)targetForAction:(SEL)arg1 withSender:(id)arg2 {
  NSLog(@"abla --- %@%@ %@%@", @"before targetForAction:", @"<SEL>", @"withSender:", arg2);
  id retval = %orig;
  NSLog(@"abla --- retval %@", retval);
  return retval;
}

%end

