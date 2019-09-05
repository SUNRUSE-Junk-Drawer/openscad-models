include <../../settings.scad>;
use <../../utilities/cylinders.scad>;
use <../../utilities/lofts.scad>;
use <../../utilities/math.scad>;
include <measurements.scad>;
include <../body/measurements.scad>;
use <../../connectors/notched_circle/female.scad>;

module hero_dualie_handle_grip() {
  number_of_rings = utilities_lofts_approximate_segments(hero_dualie_handle_height);

  front_number_of_points = ceil(cylinder_sides(hero_dualie_handle_bottom_front_diameter) / 2);
  front_points = [
    for (i = [0:front_number_of_points])
      let (angle = 180 * i / front_number_of_points)
        [-cos(angle), sin(angle)] * 0.5
  ];

  back_number_of_points = ceil(cylinder_sides(hero_dualie_handle_bottom_back_diameter) / 2);
  back_points = [
    for (i = [0:front_number_of_points])
      let (angle = 180 * i / front_number_of_points)
        [cos(angle), -sin(angle)] * 0.5
  ];

  main_handle = [
    for (ring = [0:number_of_rings])
      let(
        progress = ring / number_of_rings,
        z = progress * hero_dualie_handle_height,
        grip = (cos(progress * 360 * hero_dualie_handle_grips + 180) + 1) / 2,
        front_diameter = linear_interpolate(hero_dualie_handle_top_front_diameter, hero_dualie_handle_bottom_front_diameter, progress) * linear_interpolate(1, hero_dualie_handle_grip_scale, grip),
        front_y = (hero_dualie_handle_length - front_diameter) / 2 + pow(progress, 2.5) * hero_dualie_handle_bottom_front_x + grip * -hero_dualie_handle_grip_depth,
        back_diameter = linear_interpolate(hero_dualie_handle_top_back_diameter, hero_dualie_handle_bottom_back_diameter, progress),
        back_y = (back_diameter - hero_dualie_handle_length) / 2 + pow(progress, 1.6) * hero_dualie_handle_bottom_back_x,
        slice_front = [for (point = front_points) [point[0] * front_diameter, point[1] * front_diameter + front_y]],
        slice_back = [for (point = back_points) [point[0] * back_diameter, point[1] * back_diameter + back_y]],
        slice = concat(slice_front, slice_back)
      )
        [for (vertex = slice) [vertex[0], vertex[1], z]]
  ];

  merge_front_y = (hero_dualie_handle_length - hero_dualie_handle_merge_diameter) / 2 + hero_dualie_handle_bottom_front_x;
  merge_back_y = (hero_dualie_handle_merge_diameter - hero_dualie_handle_length) / 2 + hero_dualie_handle_bottom_back_x;

  merge_slice_front = [for (point = front_points) [point[0] * hero_dualie_handle_merge_diameter, point[1] *
    hero_dualie_handle_merge_diameter + merge_front_y, hero_dualie_handle_merge_back_y + hero_dualie_handle_height]];

  merge_slice_back = [for (point = back_points) [point[0] * hero_dualie_handle_merge_diameter, point[1] * hero_dualie_handle_merge_diameter + merge_back_y, hero_dualie_handle_merge_back_y + hero_dualie_handle_height]];

  merge_to_tube = [concat(merge_slice_front, merge_slice_back)];

  rings = concat(main_handle, merge_to_tube);

  utilities_lofts_generate(
    rings
  );
};
