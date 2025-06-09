# SwiftLint Configuration Guide

## Example SwiftLint Configuration

Below is an example of a `.swiftlint.yml` configuration file. This file defines which rules are enabled, which are disabled, and how SwiftLint should behave in your project.

```yaml
# SwiftLint Configuration File
# For Hey Caddie iOS project

# Exclude folders that should not be linted
excluded:
  - Carthage
  - Pods
  - .build

# Opt-in rules for SwiftUI and modern Swift
opt_in_rules:
  - attributes
  - closure_spacing
  - collection_alignment
  - contains_over_first_not_nil
  - empty_count
  - explicit_init
  - fatal_error_message
  - file_header
  - first_where
  - force_unwrapping
  - function_default_parameter_at_end
  - identical_operands
  - implicit_return
  - joined_default_parameter
  - last_where
  - let_var_whitespace
  - literal_expression_end_indentation
  - lower_acl_than_parent
  - modifier_order
  - multiline_arguments
  - multiline_literal_brackets
  - multiline_parameters
  - nimble_operator
  - operator_usage_whitespace
  - overridden_super_call
  - pattern_matching_keywords
  - prefer_self_in_static_references
  - prefer_zero_over_explicit_init
  - private_action
  - private_outlet
  - prohibited_interface_builder
  - redundant_nil_coalescing
  - redundant_type_annotation
  - required_enum_case
  - single_test_class
  - sorted_first_last
  - sorted_imports
  - static_operator
  - strict_fileprivate
  - toggle_bool
  - trailing_closure
  - unneeded_parentheses_in_closure_argument
  - untyped_error_in_catch
  - vertical_parameter_alignment_on_call
  - vertical_whitespace_between_cases

# Disabled rules (customize as needed)
disabled_rules:
  - line_length # Allow longer lines for SwiftUI modifiers
  - todo # Allow TODOs in code, use #warning() instead to highlight any issues
  - switch_case_on_newline
  - attributes

# Reporter
reporter: xcode
```

## Explanation and Rationale for Each Section

- **excluded:**
  - `Carthage`, `Pods`, `.build` — These directories are excluded from linting because they contain third-party dependencies or build artifacts, which should not be checked for style or quality.

- **opt_in_rules:**
  These are additional rules that are not enabled by default in SwiftLint. Enabling them helps enforce modern Swift and SwiftUI best practices. Some notable rules:
  - `attributes` — Enforces consistent attribute placement (e.g., @objc, @discardableResult).
  - `closure_spacing` — Ensures proper spacing in closures for readability.
  - `collection_alignment` — Aligns elements in multi-line collections for clarity.
  - `force_unwrapping` — Discourages the use of force unwrapping (`!`), which can lead to runtime crashes.
  - `sorted_imports` — Ensures imports are sorted, improving code organization.
  - `vertical_whitespace_between_cases` — Adds blank lines between switch cases for readability.
  - `file_header` — Enforces presence and format of file headers.
  - `private_action`, `private_outlet` — Ensures IBAction and IBOutlet are private where possible, improving encapsulation.
  - `redundant_type_annotation` — Discourages unnecessary type annotations, keeping code concise.
  - `toggle_bool` — Encourages use of `toggle()` for booleans instead of manual negation.
  - `untyped_error_in_catch` — Discourages using untyped `catch` blocks, making error handling more explicit.
  - ...and many more. See [SwiftLint Rule Directory](https://realm.github.io/SwiftLint/rule-directory.html) for full descriptions.

- **disabled_rules:**
  These rules are turned off for this project, often for practical reasons:
  - `line_length` — Allows longer lines, which is common in SwiftUI code with many chained modifiers.
  - `todo` — Allows TODO comments in code; the team prefers to use `#warning()` for highlighting issues.

- **reporter: xcode** — Sets the output format to Xcode, making lint warnings and errors easy to read in the Xcode IDE.

> For a full list of rules and their explanations, see the official [SwiftLint Rule Directory](https://realm.github.io/SwiftLint/rule-directory.html).
