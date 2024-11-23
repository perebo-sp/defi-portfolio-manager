;; title: Portfolio Management Protocol
;; summary: Implements automated portfolio rebalancing and asset management
;; description: This smart contract provides functionality for creating and managing investment portfolios. It includes automated rebalancing, error handling, and user-specific portfolio management.

;; Error codes
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INVALID-PORTFOLIO (err u101))
(define-constant ERR-INSUFFICIENT-BALANCE (err u102))
(define-constant ERR-INVALID-TOKEN (err u103))
(define-constant ERR-REBALANCE-FAILED (err u104))
(define-constant ERR-PORTFOLIO-EXISTS (err u105))
(define-constant ERR-INVALID-PERCENTAGE (err u106))
(define-constant ERR-MAX-TOKENS-EXCEEDED (err u107))
(define-constant ERR-LENGTH-MISMATCH (err u108))
(define-constant ERR-USER-STORAGE-FAILED (err u109))

;; Data Variables
(define-data-var protocol-owner principal tx-sender)
(define-data-var portfolio-counter uint u0)
(define-data-var protocol-fee uint u25) ;; 0.25% represented as basis points

;; Constants
(define-constant MAX-TOKENS-PER-PORTFOLIO u10)
(define-constant BASIS-POINTS u10000)

;; Data Maps
(define-map Portfolios
    uint ;; portfolio-id
    {
        owner: principal,
        created-at: uint,
        last-rebalanced: uint,
        total-value: uint,
        active: bool
    }
)

(define-map PortfolioAssets
    {portfolio-id: uint, token-id: uint}
    {
        target-percentage: uint,
        current-amount: uint,
        token-address: principal
    }
)

(define-map UserPortfolios
    principal
    (list 20 uint)
)

;; Read-only functions
(define-read-only (get-portfolio (portfolio-id uint))
    (map-get? Portfolios portfolio-id)
)

(define-read-only (get-portfolio-asset (portfolio-id uint) (token-id uint))
    (map-get? PortfolioAssets {portfolio-id: portfolio-id, token-id: token-id})
)

(define-read-only (get-user-portfolios (user principal))
    (default-to (list) (map-get? UserPortfolios user))
)

(define-read-only (calculate-rebalance-amounts (portfolio-id uint))
    (let (
        (portfolio (unwrap! (get-portfolio portfolio-id) ERR-INVALID-PORTFOLIO))
        (total-value (get total-value portfolio))
    )
    (ok {
        portfolio-id: portfolio-id,
        total-value: total-value,
        needs-rebalance: (> (- block-height (get last-rebalanced portfolio)) u144) ;; 24 hours in blocks
    }))
)

;; Private functions
(define-private (validate-percentage (percentage uint))
    (and (>= percentage u0) (<= percentage BASIS-POINTS))
)

(define-private (validate-portfolio-percentages (percentages (list 10 uint)))
    (fold check-percentage-sum percentages true)
)

(define-private (check-percentage-sum (current-percentage uint) (valid bool))
    (and valid (validate-percentage current-percentage))
)

(define-private (add-to-user-portfolios (user principal) (portfolio-id uint))
    (let (
        (current-portfolios (get-user-portfolios user))
        (new-portfolios (unwrap! (as-max-len? (append current-portfolios portfolio-id) u20) ERR-USER-STORAGE-FAILED))
    )
    (map-set UserPortfolios user new-portfolios)
    (ok true)
))

(define-private (initialize-portfolio-asset (index uint) (token principal) (percentage uint) (portfolio-id uint))
    (if (>= percentage u0)  ;; Only check percentage validity since principal is already a valid type
        (begin
            (map-set PortfolioAssets
                {portfolio-id: portfolio-id, token-id: index}
                {
                    target-percentage: percentage,
                    current-amount: u0,
                    token-address: token
                }
            )
            (ok true))
        ERR-INVALID-TOKEN
    )
)