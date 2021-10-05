include <../../measurements/fret.scad>;
include <fretboard_segment.scad>;

for (fret_index = [0 : fret_count - 1]) {
  printed_fretboard_segment(fret_index);
};
