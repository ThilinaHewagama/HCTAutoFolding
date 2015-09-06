//
//  xCodeHaders.h
//  AFMxCodePlugin
//
//  Created by Thilina Hewagama on 9/6/15.
//  Copyright (c) 2015 Thilina Hewagama. All rights reserved.
//

@interface IDENavigatorArea : NSObject
- (id)currentNavigator;
@end

@interface IDEWorkspaceTabController : NSObject
@property (readonly) IDENavigatorArea *navigatorArea;
@end

@interface IDEEditorContext : NSObject
- (id)editor;
@end

@interface IDEEditorArea : NSObject
- (IDEEditorContext *)lastActiveEditorContext;
@end

@interface IDEWorkspaceWindowController : NSObject
@property (readonly) IDEWorkspaceTabController *activeWorkspaceTabController;
- (IDEEditorArea *)editorArea;
@end

@interface DVTSourceTextStorage : NSTextStorage
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)string withUndoManager:(id)undoManager;
- (NSRange)lineRangeForCharacterRange:(NSRange)range;
- (NSRange)characterRangeForLineRange:(NSRange)range;
- (void)indentCharacterRange:(NSRange)range undoManager:(id)undoManager;
@end

@interface DVTSourceLanguageService : NSObject

@end

@protocol DVTSourceLanguageSyntaxTypeService <NSObject>

@end

@interface DVTTextStorage : NSTextStorage
@property(readonly) DVTSourceLanguageService *languageService;
@end


@interface DVTCompletingTextView : NSTextView
@property(readonly) DVTTextStorage *textStorage;
@end


@interface DVTDefaultSourceLanguageService : DVTSourceLanguageService
- (id)functionAndMethodRanges;
@end

@interface DVTSourceTextView : DVTCompletingTextView
- (void)foldAllMethods:(id)arg1;
@end

@interface IDESourceCodeDocument : NSDocument
- (DVTSourceTextStorage *)textStorage;
- (NSUndoManager *)undoManager;
@end

@interface IDESourceCodeEditor : NSObject
@property (retain) NSTextView *textView;
- (IDESourceCodeDocument *)sourceCodeDocument;
@end

@interface IDESourceCodeComparisonEditor : NSObject
@property (readonly) NSTextView *keyTextView;
@property (retain) NSDocument *primaryDocument;
@end
