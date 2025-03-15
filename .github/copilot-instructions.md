# GitHub Copilot Instructions for Python Projects

## General Guidelines
- Follow the PEP 8 style guide for Python code.
- Ensure code is well-documented with comments and docstrings.
- Write clear and concise code with meaningful variable and function names.
- Avoid hardcoding values; use constants or configuration files instead.
- Ensure code is modular and reusable.

## Coding Conventions
- Use snake_case for variable and function names.
- Use PascalCase for class names.
- Limit the line length to 79 characters.
- Use 4 spaces for indentation, not tabs.
- Import standard libraries first, third-party libraries next, and local modules last.

## Documentation
- Use docstrings to document all public modules, functions, classes, and methods.
- Follow the Google style guide for docstrings.
- Include type annotations for function signatures and variables.

## Testing
- Write unit tests for all functions and classes.
- Use the `unittest` or `pytest` framework for testing.
- Ensure tests cover edge cases and potential failure points.
- Run tests before pushing code to the repository.

## Error Handling
- Use exceptions to handle errors and unexpected conditions.
- Catch specific exceptions rather than using a blanket `except` statement.
- Provide informative error messages and log errors where appropriate.

## Code Quality
- Use linters like `pylint` or `flake8` to ensure code quality.
- Use type checkers like `mypy` to ensure type correctness.
- Refactor code to improve readability, performance, and maintainability.

## Best Practices
- Use list comprehensions and generator expressions where appropriate.
- Avoid using global variables; prefer function parameters and return values.
- Use context managers (the `with` statement) for resource management (e.g., file handling).
- Follow the DRY (Don't Repeat Yourself) principle to reduce code duplication.

## Security
- Avoid using `eval()` and `exec()` functions.
- Sanitize inputs to prevent injection attacks.
- Use secure methods for handling passwords and sensitive data (e.g., hashing passwords).
- Regularly update dependencies to patch known vulnerabilities.

## Example Code Structure
project/ │ ├── src/ │ ├── module1.py │ ├── module2.py │ └── ... │ ├── tests/ │ ├── test_module1.py │ ├── test_module2.py │ └── ... │ ├── README.md ├── requirements.txt ├── .gitignore └── setup.py

Code

## Additional Resources
- [PEP 8 - Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)
- [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html)
- [pytest Documentation](https://docs.pytest.org/en/stable/)
- [Python Type Hints](https://docs.python.org/3/library/typing.html)
