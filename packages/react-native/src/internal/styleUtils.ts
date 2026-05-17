import type { ViewStyle } from "react-native";

export function shadowStyle(
  opacity: number,
  radius: number,
  y: number
): ViewStyle {
  return {
    shadowColor: "#000000",
    shadowOpacity: opacity,
    shadowRadius: radius,
    shadowOffset: { width: 0, height: y },
    elevation: opacity > 0 ? Math.max(1, Math.round(radius / 4)) : 0
  };
}
