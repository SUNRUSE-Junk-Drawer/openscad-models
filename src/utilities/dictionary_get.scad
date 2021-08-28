/**
 * Retrieves a value by its key from an array representing a dictionary.
 * @param dictionary An array representing a dictionary.  Its contents must be
 *                   two-item arrays, each containing a key, then a value.
 * @param key        The key of the value to retrieve.
 * @return           The value matching the specified key.
 * @throws           When the key is not in the dictionary.
 * @throws           When the key is present in the dictionary multiple times.
 */
function dictionary_get(dictionary, key) =
  assert(
    len([for (item = dictionary) if (item[0] == key) item]) >= 1,
    "The given key was not found in the given dictionary"
  )
  assert(
    len([for (item = dictionary) if (item[0] == key) item]) <= 1,
    "The given key was found multiple times in the given dictionary"
  )
  [for (item = dictionary) if (item[0] == key) item][0][1];
