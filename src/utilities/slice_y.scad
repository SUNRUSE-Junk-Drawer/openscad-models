module slice_y(bottom, top) {
  intersection() {
    translate([
      -10000,
      bottom,
      -10000,
    ]) {
      cube([
        20000,
        top - bottom,
        20000,
      ]);
    };

    children();
  };
};
