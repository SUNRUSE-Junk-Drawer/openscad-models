use <../frame.scad>;
use <../inlay.scad>;
use <../glazings/a4_glazing.scad>;
use <../backings/a4_backing.scad>;
use <../borders/rounded_flat_border.scad>;
use <../inlays/nintendo_ds_game_card_inlay.scad>;
use <../../utilities/slice_x.scad>;
use <../../utilities/slice_y.scad>;

settings = [
  ["glazing", a4_glazing()],
  ["backing", a4_backing()],
  [
    "border",
    rounded_flat_border([
      ["thickness_mm", 17.5],
      ["sides", 256],
    ]),
  ],
  [
    "inlays", [
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", -91],
            ["y_mm", -64],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", -91],
            ["y_mm", 64],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", -91],
            ["y_mm", 0],
          ],
        ],
      ]),      
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", -30.33333333333333],
            ["y_mm", -64],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", -30.33333333333333],
            ["y_mm", 64],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", -30.33333333333333],
            ["y_mm", 0],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", 30.33333333333333],
            ["y_mm", -64],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", 30.33333333333333],
            ["y_mm", 64],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", 30.33333333333333],
            ["y_mm", 0],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", 91],
            ["y_mm", -64],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", 91],
            ["y_mm", 64],
          ],
        ],
      ]),
      nintendo_ds_game_card_inlay([
        [
          "origin", [
            ["x_mm", 91],
            ["y_mm", 0],
          ],
        ],
      ]),
    ],
  ],
];

translate([-150, 0, 0]) {
  slice_x(-10000, 0) {
    frame(settings);
  };
};

translate([-10, 0, 0]) {
  slice_x(-10000, -60.66666666666667) {
    inlay(settings);
  };
};

slice_x(-60.66666666666667, 60.66666666666667) {
  inlay(settings);
};

translate([10, 0, 0]) {
  slice_x(60.66666666666667, 10000) {
    inlay(settings);
  };
};

translate([150, 0, 0]) {
  slice_x(0, 10000) {
    frame(settings);
  };
};
