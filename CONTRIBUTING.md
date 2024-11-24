# Contributing to Portfolio Management Protocol

Thank you for considering contributing to the Portfolio Management Protocol! We value your input and strive to make contributing as seamless as possible. This document outlines the contribution guidelines to help maintain the quality and consistency of the project.

---

## Table of Contents

- [Contributing to Portfolio Management Protocol](#contributing-to-portfolio-management-protocol)
	- [Table of Contents](#table-of-contents)
	- [Getting Started](#getting-started)
	- [How to Contribute](#how-to-contribute)
		- [Reporting Bugs](#reporting-bugs)
		- [Suggesting Features](#suggesting-features)
		- [Submitting Code Changes](#submitting-code-changes)
	- [Development Guidelines](#development-guidelines)
		- [Coding Standards](#coding-standards)
		- [Testing](#testing)
		- [Documentation](#documentation)
	- [Pull Request Process](#pull-request-process)

---

## Getting Started

1. **Fork the Repository:** Fork the repository to your GitHub account to make changes without affecting the original project.
2. **Clone the Repository:** Clone the forked repository to your local machine.

   ```bash
   git clone https://github.com/your-username/defi-portfolio-manager.git
   cd portfolio-management
   ```

3. **Install Dependencies:** Install the required tools such as [Clarinet](https://www.hiro.so/clarinet).

   ```bash
   clarinet requirements
   ```

4. **Set Up Your Development Environment:** Follow the instructions in the [README.md](README.md) to ensure your environment is ready for development.

---

## How to Contribute

### Reporting Bugs

If you encounter a bug, please open an issue with the following information:

- A clear description of the bug
- Steps to reproduce the issue
- Expected and actual behavior
- Any relevant error messages or logs

### Suggesting Features

To suggest a new feature, open an issue with:

- A detailed description of the feature
- Use cases and benefits
- Any potential challenges or limitations

### Submitting Code Changes

We welcome code contributions, including bug fixes, feature implementations, or improvements. Please follow the development guidelines and pull request process outlined below.

---

## Development Guidelines

### Coding Standards

- Follow the Clarity language best practices.
- Use meaningful variable and function names.
- Adhere to the project's style for indentation, spacing, and comments.

### Testing

- Write unit tests for new features or bug fixes using Clarinet.
- Ensure existing tests pass before submitting a pull request.
- Run the test suite locally:

  ```bash
  clarinet console
  ```

### Documentation

- Update the [README.md](README.md), [CONTRIBUTING.md](CONTRIBUTING.md), or other documentation files for changes affecting users or contributors.
- Add inline comments to explain complex logic in your code.

---

## Pull Request Process

1. **Branch Naming:**

   - Use descriptive branch names. For example:
     - `bugfix/fix-rebalance-logic`
     - `feature/add-new-portfolio-metrics`

2. **Commit Messages:**

   - Write clear and concise commit messages. For example:
     - `Fix: Correct rebalance logic for edge cases`
     - `Add: Support for portfolio deletion`

3. **Testing:**

   - Ensure all tests pass locally.
   - Include tests for new functionality or bug fixes.

4. **Open a Pull Request:**

   - Push your branch to your forked repository.
   - Open a pull request (PR) to the `main` branch of the original repository.
   - Provide a detailed description of your changes, linking any relevant issues.

5. **Review Process:**

   - Wait for maintainers to review your PR.
   - Address any requested changes promptly.

6. **Merging:**
   - Once approved, a maintainer will merge your PR. Do not merge your own pull requests unless explicitly authorized.

---

Thank you for contributing to the Portfolio Management Protocol! We’re excited to work with you to improve and expand the project.
