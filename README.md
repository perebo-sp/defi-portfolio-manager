# Portfolio Management Protocol

A Clarity smart contract for automated portfolio management and rebalancing on the Stacks blockchain. This protocol enables users to create, manage, and automatically rebalance investment portfolios with multiple tokens.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Contract Components](#contract-components)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Error Codes](#error-codes)
- [Technical Specifications](#technical-specifications)
- [Security Considerations](#security-considerations)

## Overview

The Portfolio Management Protocol is designed to provide a decentralized solution for managing investment portfolios on the Stacks blockchain. It allows users to create portfolios with multiple tokens, set target allocations, and perform automated rebalancing to maintain desired asset distributions.

## Features

- Create customized investment portfolios with up to 10 tokens
- Set and update target allocation percentages for each asset
- Automated portfolio rebalancing mechanism
- Portfolio tracking and management
- User-specific portfolio listings
- Protocol-level fee management
- Comprehensive error handling

## Contract Components

### Data Structures

1. **Portfolios Map**

   - Tracks portfolio metadata including:
     - Owner
     - Creation timestamp
     - Last rebalance timestamp
     - Total value
     - Active status
     - Token count

2. **PortfolioAssets Map**

   - Stores asset-specific information:
     - Target percentage
     - Current amount
     - Token address

3. **UserPortfolios Map**
   - Maintains a list of portfolio IDs per user

### Constants

- `MAX-TOKENS-PER-PORTFOLIO`: 10 tokens
- `BASIS-POINTS`: 10000 (Used for percentage calculations)
- Protocol fee: 0.25% (25 basis points)

## Getting Started

### Prerequisites

- Clarity CLI
- Stacks blockchain node
- Clarinet for testing and deployment

### Installation

1. Clone the contract repository
2. Install dependencies:

```bash
clarinet requirements
```

3. Build the contract:

```bash
clarinet build
```

## Usage

### Creating a Portfolio

```clarity
(contract-call? .portfolio-management create-portfolio
    (list 'token1 'token2) ;; token principals
    (list u5000 u5000))    ;; percentages in basis points (50% each)
```

### Rebalancing a Portfolio

```clarity
(contract-call? .portfolio-management rebalance-portfolio u1)
```

### Updating Asset Allocation

```clarity
(contract-call? .portfolio-management update-portfolio-allocation
    u1  ;; portfolio-id
    u0  ;; token-id
    u6000) ;; new percentage (60%)
```

### Querying Portfolio Information

```clarity
(contract-call? .portfolio-management get-portfolio u1)
(contract-call? .portfolio-management get-portfolio-asset u1 u0)
(contract-call? .portfolio-management get-user-portfolios tx-sender)
```

## Error Codes

| Code | Description          |
| ---- | -------------------- |
| u100 | Not authorized       |
| u101 | Invalid portfolio    |
| u102 | Insufficient balance |
| u103 | Invalid token        |
| u104 | Rebalance failed     |
| u105 | Portfolio exists     |
| u106 | Invalid percentage   |
| u107 | Max tokens exceeded  |
| u108 | Length mismatch      |
| u109 | User storage failed  |
| u110 | Invalid token ID     |

## Technical Specifications

### Portfolio Creation Rules

- Maximum of 10 tokens per portfolio
- Percentages must sum to 100% (10000 basis points)
- Each token must be a valid principal
- Token count must match percentage count

### Rebalancing Mechanism

- Automated rebalancing available after 24 hours (144 blocks)
- Only portfolio owner can trigger rebalancing
- Updates last-rebalanced timestamp automatically

## Security Considerations

1. **Access Control**

   - Only portfolio owners can modify their portfolios
   - Protocol owner controls are limited to initialization
   - Non-custodial design for user assets

2. **Input Validation**

   - Strict percentage validation (0-100%)
   - Token address verification
   - Portfolio existence checks

3. **Error Handling**

   - Comprehensive error codes
   - Failed operation reversal
   - Clear error messages

4. **Limitations**
   - Maximum 10 tokens per portfolio
   - Maximum 20 portfolios per user
   - 24-hour minimum between rebalances

## Contributing

This project welcomes contributions. See the [CONTRIBUTING.md](CONTRIBUTING.md) file for details on the code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
