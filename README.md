# Roman

[![Package Version](https://img.shields.io/hexpm/v/roman)](https://hex.pm/packages/roman)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/roman/)

A Gleam library for converting between Roman numerals and integers, with support for both string and structured representations.

## Installation

```sh
gleam add roman@1
```

## Usage

### Types

The library provides several types for working with Roman numerals:

- `Roman` - A list of numerals representing a Roman number
- `Numeral` - Individual Roman numeral characters (I, V, X, L, C, D, M)
- `RomanError` - Error type for invalid inputs

### Converting Strings to Roman Numerals

```gleam
import roman

// Convert a string to Roman numerals
let result = roman.string_to_roman("xlii")
// Returns: Ok([X, L, I, I])

// Invalid characters return an error
let error = roman.string_to_roman("abc")
// Returns: Error(InvalidNumeralCharInput)
```

### Converting Roman Numerals to Integers

```gleam
import roman

// First convert string to Roman, then to integer
let roman_numerals = roman.string_to_roman("xlii")
case roman_numerals {
  Ok(numerals) -> {
    let value = roman.roman_to_int(numerals)
    // Returns: 42
  }
  Error(_) -> // handle error
}
```

### Converting Integers to Roman Numerals

```gleam
import roman

// Convert integer to Roman numerals
let roman_numerals = roman.int_to_roman(42)
// Returns: Ok([X, L, I, I])

// Zero and negative numbers return None
let invalid = roman.int_to_roman(0)
// Returns: Error(ZeroOrNegativeIntegerInput)
```

### Converting Roman Numerals to Strings

```gleam
import roman

// Convert Roman numerals back to string
let roman_numerals = roman.int_to_roman(42)
case roman_numerals {
  Some(numerals) -> {
    let roman_string = roman.roman_to_string(numerals)
    // Returns: "xlii"
  }
  None -> // handle invalid input
}
```

## Supported Roman Numerals

The library supports all standard Roman numerals:

- `I` = 1
- `V` = 5
- `X` = 10
- `L` = 50
- `C` = 100
- `D` = 500
- `M` = 1000

## Features

- ✅ Convert strings to Roman numeral structures
- ✅ Convert Roman numerals to integers (handles subtractive notation)
- ✅ Convert integers to Roman numerals
- ✅ Convert Roman numerals back to strings
- ✅ Proper error handling for invalid inputs
- ✅ Support for subtractive notation (e.g., IV = 4, IX = 9)

## Error Handling

The library provides proper error handling:

- `string_to_roman` returns `Result(Roman, RomanError)` - fails on invalid characters
- `int_to_roman` returns `Option(Roman)` - returns `None` for zero or negative numbers
- `roman_to_int` always succeeds for valid Roman structures

## Documentation

Further documentation can be found at <https://hexdocs.pm/gleam_roman/>.
