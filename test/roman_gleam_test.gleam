import gleam/list
import gleeunit
import roman.{
  C, D, I, InvalidNumeralCharInput, L, M, V, X, ZeroOrNegativeIntegerInput,
}

pub fn main() -> Nil {
  string_to_roman()
  string_to_roman_error()
  roman_to_int()
  int_to_roman()
  int_to_roman_error()
  roman_to_string()
  roundtrip()
  gleeunit.main()
}

// string_to_roman
pub fn string_to_roman() {
  assert roman.string_to_roman("MCMLXXXIV") == Ok([M, C, M, L, X, X, X, I, V])
  assert roman.string_to_roman("mcmlxxxiv") == Ok([M, C, M, L, X, X, X, I, V])
  assert roman.string_to_roman("I") == Ok([I])
  assert roman.string_to_roman("IV") == Ok([I, V])
  assert roman.string_to_roman("IX") == Ok([I, X])
  assert roman.string_to_roman("XL") == Ok([X, L])
  assert roman.string_to_roman("XC") == Ok([X, C])
  assert roman.string_to_roman("CD") == Ok([C, D])
  assert roman.string_to_roman("CM") == Ok([C, M])
}

pub fn string_to_roman_error() {
  assert roman.string_to_roman("MCMLXXXIVZ") == Error(InvalidNumeralCharInput)
  assert roman.string_to_roman("123") == Error(InvalidNumeralCharInput)
}

// roman_to_int
pub fn roman_to_int() {
  assert roman.roman_to_int([I]) == 1
  assert roman.roman_to_int([I, V]) == 4
  assert roman.roman_to_int([I, X]) == 9
  assert roman.roman_to_int([X, L]) == 40
  assert roman.roman_to_int([X, C]) == 90
  assert roman.roman_to_int([C, D]) == 400
  assert roman.roman_to_int([C, M]) == 900
  assert roman.roman_to_int([M, C, M, L, X, X, X, I, V]) == 1984
  assert roman.roman_to_int([M, M, M, C, M, X, C, I, X]) == 3999
}

// int_to_roman
pub fn int_to_roman() {
  assert roman.int_to_roman(1) == Ok([I])
  assert roman.int_to_roman(4) == Ok([I, V])
  assert roman.int_to_roman(9) == Ok([I, X])
  assert roman.int_to_roman(40) == Ok([X, L])
  assert roman.int_to_roman(44) == Ok([X, L, I, V])
  assert roman.int_to_roman(90) == Ok([X, C])
  assert roman.int_to_roman(400) == Ok([C, D])
  assert roman.int_to_roman(900) == Ok([C, M])
  assert roman.int_to_roman(1984) == Ok([M, C, M, L, X, X, X, I, V])
  assert roman.int_to_roman(1990) == Ok([M, C, M, X, C])
  assert roman.int_to_roman(3999) == Ok([M, M, M, C, M, X, C, I, X])
}

pub fn int_to_roman_error() {
  assert roman.int_to_roman(-1) == Error(ZeroOrNegativeIntegerInput)
  assert roman.int_to_roman(0) == Error(ZeroOrNegativeIntegerInput)
}

// roman_to_string
pub fn roman_to_string() {
  assert roman.roman_to_string([I]) == "i"
  assert roman.roman_to_string([M, C, M, L, X, X, X, I, V]) == "mcmlxxxiv"
  assert roman.roman_to_string([]) == ""
}

// roundtrip
pub fn roundtrip() {
  let values = [1, 4, 9, 40, 44, 90, 400, 900, 1984, 1990, 3999]
  list.each(values, fn(n) {
    let assert Ok(numerals) = roman.int_to_roman(n)
    assert roman.roman_to_int(numerals) == n
  })
}
