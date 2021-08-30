module slice_x(left, right) {
  intersection() {
    translate([
      left,
      -10000,
      -10000,
    ]) {
      cube([
        right - left,
        20000,
        20000,
      ]);
    };

    children();
  };
};
