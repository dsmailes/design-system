import React from "react";
import { AppTextField, type AppTextFieldProps } from "./AppTextField";

export type AppMultilineFieldProps = Omit<AppTextFieldProps, "multiline"> & {
  minHeight?: number;
};

export function AppMultilineField({
  minHeight = 120,
  textAlignVertical = "top",
  style,
  ...props
}: AppMultilineFieldProps) {
  return (
    <AppTextField
      {...props}
      multiline
      textAlignVertical={textAlignVertical}
      style={[{ minHeight, paddingVertical: 12 }, style]}
    />
  );
}
