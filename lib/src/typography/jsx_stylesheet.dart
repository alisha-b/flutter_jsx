import 'package:flutter/cupertino.dart';

/// Flutter's responsive configuration similar to display Html property
enum DisplayLine {
  /// Text element should occupy the entire line
  block,

  /// Text element should adjust his size to only occupy what it needs
  inline
}

/// Stylesheet that contemplates all properties that could be applied to a single text element inside ResponsiveText widget.
/// OBS: Please, be aware about the differences between [TextAlign] and [Alignment] properties before proceed.
class JSXStylesheet {
  /// Text style to be applied to the text element
  TextStyle textStyle;

  /// Determines how the text overflow should be handled
  TextOverflow textOverflow;

  /// Determines if the text element should occupy all line or not
  DisplayLine displayLine;

  /// Box decoration containing configurations such as borders, background color, degrade effects, etc.
  BoxDecoration boxDecoration;

  /// Internal space which separates the box border from the internal elements
  EdgeInsets padding;

  /// External space which separates the box border from the outside elements
  EdgeInsets margin;

  /// Text alignment applied over internal text elements, respecting the vertical text base line.
  TextAlign textAlign;

  /// Alignment of the objects inside the box. The elements aligned does not respect the vertical text base line.
  Alignment alignment;

  /// Determines the opacity of the element and its children
  double opacity;

  /// A fixed box width, which could result in wrap and overflow text
  double width;

  /// A fixed box height, which could result in wrap and overflow text
  double height;

  /// Amount of text indentation to be applied over text element. The indentation is achieved adding a tab character (\t) before first letter´s line.
  int textIndent;

  /// Defines box border radius to the element
  BorderRadius borderRadius;

  /// Line alignment
  PlaceholderAlignment placeholderAlignment;

  /// Box alignment for X axis
  MainAxisAlignment mainAxisAlignment;

  /// Box alignment for Y axis
  CrossAxisAlignment crossAxisAlignment;

  JSXStylesheet({
    this.padding,
    this.margin,
    this.textStyle,
    this.textOverflow = TextOverflow.clip,
    this.displayLine = DisplayLine.inline,
    this.boxDecoration,
    this.opacity = 1.0,
    this.textAlign, // = TextAlign.left,
    this.alignment, // = Alignment.topLeft,
    this.placeholderAlignment,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.borderRadius,
    this.textIndent = 0,
    this.width,
    this.height,
  });

  /// Merge two EdgeInsets objects, merging empty properties. If both properties are defined, than the new property replaces the old one.
  EdgeInsets mergeEdges(EdgeInsets older, EdgeInsets newer) {
    if (newer == null) return older?.copyWith();
    if (older == null) return newer?.copyWith();

    return older.copyWith(
        bottom: newer.bottom,
        top: newer.top,
        left: newer.left,
        right: newer.right);
  }

  /// Merge the stylesheet, replacing the actual parameters by the new ones, when they are defined. Otherwise the old property is preserved.
  /// [mergeBoxProperties] Define if box properties should be merged. Otherwise all box properties receives null values.
  JSXStylesheet merge(JSXStylesheet newStylesheet,
      {bool mergeBoxProperties = false}) {
    if (newStylesheet != null) {
      textStyle = textStyle == null
          ? newStylesheet.textStyle
          : (newStylesheet.textStyle == null
              ? textStyle
              : textStyle.merge(newStylesheet.textStyle));
      textStyle?.merge(TextStyle(inherit: true));
      opacity = newStylesheet.opacity ?? opacity;
      textAlign = newStylesheet.textAlign ?? textAlign;
      alignment = newStylesheet.alignment ?? alignment;
      placeholderAlignment =
          newStylesheet.placeholderAlignment ?? placeholderAlignment;
      textIndent = newStylesheet.textIndent ?? textIndent;
      displayLine = newStylesheet.displayLine ?? displayLine;
      textOverflow = newStylesheet.textOverflow ?? textOverflow;
      mainAxisAlignment = newStylesheet.mainAxisAlignment ?? mainAxisAlignment;
      crossAxisAlignment =
          newStylesheet.crossAxisAlignment ?? crossAxisAlignment;

      if (mergeBoxProperties) {
        width = newStylesheet.width ?? width;
        height = newStylesheet.height ?? height;
        margin = mergeEdges(margin, newStylesheet.margin);
        padding = mergeEdges(padding, newStylesheet.padding);
        boxDecoration = newStylesheet.boxDecoration ?? boxDecoration;
        borderRadius = newStylesheet.borderRadius ?? borderRadius;
      }
    }
    return this;
  }

  /// Cascade the stylesheet, combining two stylesheets into a new one.
  static JSXStylesheet cascade(
      JSXStylesheet oldStylesheet, JSXStylesheet newStylesheet,
      {bool mergeBoxProperties = false}) {
    JSXStylesheet resultedStylesheet = JSXStylesheet();

    if (oldStylesheet != null) {
      resultedStylesheet.merge(oldStylesheet,
          mergeBoxProperties: mergeBoxProperties);
    }

    if (newStylesheet != null) {
      resultedStylesheet.merge(newStylesheet,
          mergeBoxProperties: mergeBoxProperties);
    }

    return resultedStylesheet;
  }
}
