export type AppControlSize = "compact" | "regular" | "large";

export type AppControlMetrics = {
  minHeight: number;
  horizontalPadding: number;
  iconDimension: number;
};

const sizes: Record<AppControlSize, AppControlMetrics> = {
  compact: {
    minHeight: 44,
    horizontalPadding: 14,
    iconDimension: 15
  },
  regular: {
    minHeight: 50,
    horizontalPadding: 18,
    iconDimension: 17
  },
  large: {
    minHeight: 56,
    horizontalPadding: 22,
    iconDimension: 18
  }
};

export function controlSize(size: AppControlSize): AppControlMetrics {
  return sizes[size];
}
