function linear_interpolate(
  from,
  to,
  mix
) = from + (to - from) * mix;

function remap(
  value,
  fromLow,
  fromHigh,
  toLow,
  toHigh
) = linear_interpolate(toLow, toHigh, (value - fromLow) / (fromHigh - fromLow));
