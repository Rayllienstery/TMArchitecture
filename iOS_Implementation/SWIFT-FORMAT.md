# Swift Code Style Guide

## Setting Up Swift Code Formatting

To ensure consistent code style across the project, use automatic formatting with a `.swift-format` configuration file.

### Setup Steps

1. Create a file named `.swift-format` in the root of your project.
2. Copy the following configuration into it:

```json
{
    "version": 1,
    "fileScopedDeclarationPrivacy": {
        "accessLevel": "private"
    },
    "indentBlankLines": false,
    "indentConditionalCompilationBlocks": true,
    "indentSwitchCaseLabels": false,
    "indentation": {
        "spaces": 2
    },
    "lineBreakAroundMultilineExpressionChainComponents": false,
    "lineBreakBeforeControlFlowKeywords": false,
    "lineBreakBeforeEachArgument": true,
    "lineBreakBeforeEachGenericRequirement": false,
    "lineBreakBetweenDeclarationAttributes": false,
    "lineLength": 120,
    "maximumBlankLines": 1,
    "multiElementCollectionTrailingCommas": false,
    "noAssignmentInExpressions": {
        "allowedFunctions": [
            "XCTAssertNoThrow"
        ]
    },
    "prioritizeKeepingFunctionOutputTogether": false,
    "respectsExistingLineBreaks": true,
    "verticalWhitespaceBetweenCases": true,
    "spacesAroundRangeFormationOperators": false,
    "spacesBeforeEndOfLineComments": 2,
    "tabWidth": 2
}
```

### Explanation and Rationale for Each Setting

- **fileScopedDeclarationPrivacy.accessLevel: private** — Makes file-scoped declarations private by default, improving encapsulation and reducing accidental API exposure.
- **indentBlankLines: false** — Keeps blank lines unindented, making code visually cleaner.
- **indentConditionalCompilationBlocks: true** — Indents code inside #if/#endif blocks, improving readability of conditional code.
- **indentSwitchCaseLabels: false** — Case labels are not indented, matching common Swift style and making switch statements more compact.
- **indentation.spaces: 2** — Uses 2 spaces per indentation level, which is widely accepted and keeps code compact and readable.
- **lineBreakAroundMultilineExpressionChainComponents: false** — Avoids extra line breaks in chained expressions, keeping related code visually grouped.
- **lineBreakBeforeControlFlowKeywords: false** — No extra line break before control flow keywords (like else, catch), resulting in more compact code.
- **lineBreakBeforeEachArgument: true** — Puts each function argument on a new line, improving readability for functions with many parameters.
- **lineBreakBeforeEachGenericRequirement: false** — Keeps generic requirements on the same line, reducing vertical space for simple generics.
- **lineBreakBetweenDeclarationAttributes: false** — Keeps declaration attributes together, making code less fragmented.
- **lineLength: 120** — Sets a maximum line length of 120 characters, balancing readability and the need to avoid excessive wrapping.
- **maximumBlankLines: 1** — Limits consecutive blank lines to 1, keeping code visually tight and avoiding unnecessary whitespace.
- **multiElementCollectionTrailingCommas: false** — No trailing comma after the last element in collections, matching common Swift style.
- **noAssignmentInExpressions.allowedFunctions: ["XCTAssertNoThrow"]** — Allows assignment in expressions only for specific functions (like XCTest assertions), preventing accidental assignment in conditions elsewhere.
- **prioritizeKeepingFunctionOutputTogether: false** — Does not force function output to stay together, allowing more flexible formatting.
- **respectsExistingLineBreaks: true** — Respects manual line breaks, giving developers some control over formatting.
- **verticalWhitespaceBetweenCases: true** — Adds a blank line between switch cases, improving readability of large switch statements.
- **spacesAroundRangeFormationOperators: false** — No extra spaces around range operators (e.g., 1...10), matching Swift conventions.
- **spacesBeforeEndOfLineComments: 2** — Ensures two spaces before end-of-line comments, making comments easier to read.
- **tabWidth: 2** — Sets tab width to 2 spaces, matching the indentation setting and ensuring consistent alignment.

> For a full list of options, see the official [swift-format documentation](https://github.com/apple/swift-format).
