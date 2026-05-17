import type { TextStyle } from "react-native";

export type AppTextStyle =
  | "eyebrow"
  | "display"
  | "title"
  | "section"
  | "body"
  | "bodyEmphasis"
  | "detail"
  | "caption"
  | "numeric";

const styles: Record<AppTextStyle, TextStyle> = {
  eyebrow: {
    fontSize: 12,
    lineHeight: 16,
    fontWeight: "600",
    letterSpacing: 0.8,
    textTransform: "uppercase"
  },
  display: {
    fontSize: 34,
    lineHeight: 41,
    fontWeight: "700",
    letterSpacing: 0
  },
  title: {
    fontSize: 22,
    lineHeight: 28,
    fontWeight: "600",
    letterSpacing: 0
  },
  section: {
    fontSize: 17,
    lineHeight: 22,
    fontWeight: "600",
    letterSpacing: 0
  },
  body: {
    fontSize: 17,
    lineHeight: 24,
    fontWeight: "400",
    letterSpacing: 0
  },
  bodyEmphasis: {
    fontSize: 17,
    lineHeight: 24,
    fontWeight: "600",
    letterSpacing: 0
  },
  detail: {
    fontSize: 16,
    lineHeight: 22,
    fontWeight: "400",
    letterSpacing: 0
  },
  caption: {
    fontSize: 13,
    lineHeight: 18,
    fontWeight: "400",
    letterSpacing: 0
  },
  numeric: {
    fontSize: 17,
    lineHeight: 24,
    fontWeight: "500",
    letterSpacing: 0,
    fontVariant: ["tabular-nums"]
  }
};

export function textStyle(style: AppTextStyle): TextStyle {
  return styles[style];
}
