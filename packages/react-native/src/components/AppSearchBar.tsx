import React from "react";
import { AppTextField, type AppTextFieldProps } from "./AppTextField";

export type AppSearchBarProps = Omit<AppTextFieldProps, "label" | "icon"> & {
  label?: string;
};

export function AppSearchBar({
  label = "Search",
  returnKeyType = "search",
  ...props
}: AppSearchBarProps) {
  return (
    <AppTextField
      {...props}
      label={label}
      icon="search"
      returnKeyType={returnKeyType}
    />
  );
}
