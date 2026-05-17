import {
  AppSpacing,
  AppMotion,
  resolveColorToken,
  textStyle,
  controlSize,
  type AppColorToken
} from "../foundation";

describe("foundation tokens", () => {
  it("uses high contrast color overrides", () => {
    const token: AppColorToken = {
      light: "#111111",
      dark: "#eeeeee",
      lightHighContrast: "#000000",
      darkHighContrast: "#ffffff"
    };

    expect(resolveColorToken(token, "light", "increased")).toBe("#000000");
    expect(resolveColorToken(token, "dark", "increased")).toBe("#ffffff");
    expect(resolveColorToken(token, "dark", "normal")).toBe("#eeeeee");
  });

  it("orders the spacing scale", () => {
    expect(AppSpacing.xxSmall).toBeLessThan(AppSpacing.small);
    expect(AppSpacing.small).toBeLessThan(AppSpacing.large);
    expect(AppSpacing.large).toBeLessThan(AppSpacing.xxLarge);
    expect(AppSpacing.pageInset).toBeLessThanOrEqual(AppSpacing.sectionGap);
  });

  it("collapses motion duration when reduced motion is enabled", () => {
    expect(AppMotion.duration(true)).toBe(0.01);
    expect(AppMotion.duration(false, true)).toBe(AppMotion.emphasis);

    const { duration } = AppMotion;
    expect(duration(false, true)).toBe(AppMotion.emphasis);
  });

  it("returns stable typography styles", () => {
    expect(textStyle("body").fontSize).toBe(17);
    expect(textStyle("bodyEmphasis").fontWeight).toBe("600");
    expect(textStyle("numeric").fontVariant).toEqual(["tabular-nums"]);
  });

  it("returns stable control sizes", () => {
    expect(controlSize("compact").minHeight).toBe(44);
    expect(controlSize("regular").horizontalPadding).toBe(18);
    expect(controlSize("large").minHeight).toBe(56);
  });
});
