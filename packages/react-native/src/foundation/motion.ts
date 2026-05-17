const quick = 0.16;
const standard = 0.24;
const emphasisDuration = 0.34;

export const AppMotion = {
  quick,
  standard,
  emphasis: emphasisDuration,
  duration(reduceMotion: boolean, emphasis = false) {
    if (reduceMotion) {
      return 0.01;
    }
    return emphasis ? emphasisDuration : standard;
  }
} as const;
