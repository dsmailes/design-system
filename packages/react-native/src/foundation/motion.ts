export const AppMotion = {
  quick: 0.16,
  standard: 0.24,
  emphasis: 0.34,
  duration(reduceMotion: boolean, emphasis = false) {
    if (reduceMotion) {
      return 0.01;
    }
    return emphasis ? this.emphasis : this.standard;
  }
} as const;
