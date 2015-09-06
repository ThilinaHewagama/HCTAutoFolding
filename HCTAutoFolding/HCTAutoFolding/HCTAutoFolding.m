//
//  AFMxCodePlugin.m
//  AFMxCodePlugin
//
//  Created by Thilina Hewagama on 9/5/15.
//  Copyright (c) 2015 Thilina Hewagama. All rights reserved.
//

#import "HCTAutoFolding.h"

@interface HCTAutoFolding()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation HCTAutoFolding

+ (instancetype)sharedPlugin{
  return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin{
  if (self = [super init]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(foldFunctionsAndMethodsWhenOpen:) name:@"IDESourceCodeEditorDidFinishSetup" object:nil];
    // reference to plugin's bundle, for resource access
    self.bundle = plugin;
  }
  return self;
}

- (void) foldFunctionsAndMethodsWhenOpen:(NSNotification*)notification{
  
  if ([NSStringFromClass([notification.object class]) isEqualToString:@"IDESourceCodeEditor"] && [notification.name isEqualToString:@"IDESourceCodeEditorDidFinishSetup"]){
    
    DVTSourceTextView *sourceTextView = (DVTSourceTextView *)[[self class] currentSourceCodeTextView];
    if (!sourceTextView) return;
    
    
    DVTTextStorage *textStorage = [sourceTextView textStorage];
    if (!textStorage) return;
    
    DVTDefaultSourceLanguageService *languageService = (DVTDefaultSourceLanguageService *)[textStorage languageService];
    if (!languageService) return;
    
    NSMutableArray *functionAndMethodRanges = [languageService functionAndMethodRanges];
    if (!functionAndMethodRanges) return;
    
    if (functionAndMethodRanges.count>0)[sourceTextView foldAllMethods:self];
    
  }
  
}

#pragma mark - Helper Methods

+ (id)currentEditor {
  NSWindowController *currentWindowController = [[NSApp keyWindow] windowController];
  if ([currentWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")]) {
    IDEWorkspaceWindowController *workspaceController = (IDEWorkspaceWindowController *)currentWindowController;
    IDEEditorArea *editorArea = [workspaceController editorArea];
    IDEEditorContext *editorContext = [editorArea lastActiveEditorContext];
    return [editorContext editor];
  }
  return nil;
}

+ (IDESourceCodeDocument *)currentSourceCodeDocument {
  if ([[self currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
    IDESourceCodeEditor *editor = [self currentEditor];
    return editor.sourceCodeDocument;
  }
  
  if ([[self currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeComparisonEditor")]) {
    IDESourceCodeComparisonEditor *editor = [[self class] currentEditor];
    if ([[editor primaryDocument] isKindOfClass:NSClassFromString(@"IDESourceCodeDocument")]) {
      IDESourceCodeDocument *document = (IDESourceCodeDocument *)editor.primaryDocument;
      return document;
    }
  }
  
  return nil;
}

+ (NSTextView *)currentSourceCodeTextView {
  if ([[[self class] currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeEditor")]) {
    IDESourceCodeEditor *editor = [[self class] currentEditor];
    return editor.textView;
  }
  
  if ([[[self class] currentEditor] isKindOfClass:NSClassFromString(@"IDESourceCodeComparisonEditor")]) {
    IDESourceCodeComparisonEditor *editor = [[self class] currentEditor];
    return editor.keyTextView;
  }
  
  return nil;
}

- (void)dealloc{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
